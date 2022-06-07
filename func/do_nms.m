function out_boxes = do_nms(boxes, thresh, nms_thresh)
out_boxes = [];
for i = 1:size(boxes,1)
    if boxes(i,1) > thresh
        this_class = boxes(i,2);
        out_boxes = [out_boxes; boxes(i,:)];
        for j = i+1:size(boxes,1)
            if boxes(j,2) == this_class
                iou_perc = iou(boxes(i,:),boxes(j,:));
                if iou_perc > nms_thresh
                    boxes(j,:) = 0;
                end
            end
        end
    end
end
