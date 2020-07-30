$(document).ready(function(){
    getDataResult();

    $(window).scroll(function (e) {
        var available = $(document).height();
        var percentage_of_page = 0.7;
        var height = $(window).scrollTop();
        twoThird_screen = available * percentage_of_page;

        if (height > twoThird_screen ) {
            
        }
    });

    $('td#kanaPrefix a').click(function(event){
        var kanaPrefix = $(this).attr("href");
        event.preventDefault();
        $('td#kanaPrefix a').removeClass( "filter" );

        if (kanaPrefix == $('#kanaPrefixFilter').val())
        {
            $('#kanaPrefixFilter').val('');
            $('a.namePrefixLink').removeClass('disableLink');
        }
        else
        {
            $('a.namePrefixLink').addClass('disableLink');
            $('#kanaPrefixFilter').val(kanaPrefix);
            $(this).addClass('filter');
        }

        getDataResult();
    });

    $('td#namePrefix a').click(function(event){
        var namePrefix = $(this).attr("href");
        event.preventDefault();
        $('td#namePrefix a').removeClass( "filter" );

        if (namePrefix == $('#namePrefixFilter').val())
        {
            $('#namePrefixFilter').val('');
            $('a.kanaPrefixLink').removeClass('disableLink');
        }
        else
        {
            $('a.kanaPrefixLink').addClass('disableLink');
            $('#namePrefixFilter').val(namePrefix);
            $(this).addClass('filter');
        }

        getDataResult();
    });

    $('td#motoDisplace a').click(function(event){
        var motoDisplace = $(this).attr("href");
        event.preventDefault();
        $('td#motoDisplace a').removeClass( "filter" );

        if (motoDisplace == $('#motoDisplacement').val())
        {
            $('#motoDisplacement').val('');
        }
        else
        {
            $('#motoDisplacement').val(motoDisplace);
            $(this).addClass('filter');
        }
        
        getDataResult();
    });

    $('td#marker a').click(function(event){
        var marker = $(this).attr("href");
        event.preventDefault();
        $('td#marker a').removeClass( "filter" );

        if (marker == $('#modelMakerCode').val())
        {
            $('#modelMakerCode').val('');
        }
        else
        {
            $('#modelMakerCode').val(marker);
            $(this).addClass('filter');
        }

        getDataResult();
    });

});

function getDataResult()
{
    kanaPrefix = $('#kanaPrefixFilter').val();
    namePrefix = $('#namePrefixFilter').val();
    motoDisplace = $('#motoDisplacement').val();
    modelMakerCode = $('#modelMakerCode').val();

    href = 'filterMotobike/' + kanaPrefix + "/" + namePrefix + "/" + motoDisplace + "/" + modelMakerCode;

    $.ajax({
        type: 'GET',
        url: href, 
        data: $(this).serialize()
    })
    .done(function(data){
            
        // show the response
        $('#response').html(data);
            
    })
    .fail(function() {
        
        // just in case posting your form failed
        alert( "Posting failed." );           
    });
}

jQuery(function($) {
    console.log($, 'jquery works');
    console.log($("img.lazy").length);

    $("img.lazy").lazyload({
        effect : "fadeIn"
    });
});