$(document).on('turbolinks:load', ()=> {
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="post[images_attributes][${index}][url]"
                    id="post_images_attributes_${index}_url"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
  return html;
  }
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" url="${url}" width="150px" height="150px">`
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('url', blobUrl);
    } else {
      $('#previews').append(buildImg(targetIndex, blobUrl));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length -1] + 1)
    }
  });

  $('#image-box').on('change', '.js-file', function(e){
    $('#image-box').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
  });

  $('#image-box').on('click', '.js-remove', function() {
    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});