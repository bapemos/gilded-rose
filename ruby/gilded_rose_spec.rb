require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end


    context "normal items" do
      it "decreases qlty by 1" do
        items = [Item.new("Normal item 1", 30, 40)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 39
      end

      it "decreases sell_in by 1" do
        items = [Item.new("Normal item 1", 30, 40)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 29
      end

      it "does not decrease quality if zero" do
        items = [Item.new("Normal item 1", 30, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context "well-aging items" do
      it "increases qlty by 1" do
        items = [Item.new("Aged Brie", 30, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it "decreases sell_in by 1" do
        items = [Item.new("Aged Brie", 30, 40)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 29
      end

      it "does not increase quality if 50" do
        items = [Item.new("Aged Brie", 30, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    context "backstage items" do
      it "increases qlty by 1" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 30, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end

      it "decreases sell_in by 1" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 30, 40)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 29
      end

      it "does not increase quality if 50" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 30, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    context "backstage items with less 10 days" do
      it "increases qlty by 2" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      it "decreases sell_in by 1" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 30, 40)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 29
      end

      it "does not increase quality if 50" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 30, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    context "backstage items with less 6 days" do
      it "increases qlty by 3" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end

      it "decreases sell_in by 1" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 30, 40)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 29
      end

      it "does not increase quality if 50" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 30, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    context "backstage items expired" do
      it "drops qlity to zero" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', -1, 40)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

    end



  end

end
