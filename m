From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: prodikeys: make array keys static const, makes
 object smaller
Date: Tue, 1 Oct 2019 16:21:34 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1910011621240.13160@cbobk.fhfr.pm>
References: <20190905165406.24641-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905165406.24641-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 5 Sep 2019, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array keys on the stack but instead make it
> static const. Makes the object code smaller by 166 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   18931	   5872	    480	  25283	   62c3	drivers/hid/hid-prodikeys.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   18669	   5968	    480	  25117	   621d	drivers/hid/hid-prodikeys.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hid/hid-prodikeys.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
> index 21544ebff855..fb6841ebe4d9 100644
> --- a/drivers/hid/hid-prodikeys.c
> +++ b/drivers/hid/hid-prodikeys.c
> @@ -516,7 +516,7 @@ static void pcmidi_setup_extra_keys(
>  		MY PICTURES =>	KEY_WORDPROCESSOR
>  		MY MUSIC=>	KEY_SPREADSHEET
>  	*/
> -	unsigned int keys[] = {
> +	static const unsigned int keys[] = {
>  		KEY_FN,
>  		KEY_MESSENGER, KEY_CALENDAR,
>  		KEY_ADDRESSBOOK, KEY_DOCUMENTS,
> @@ -532,7 +532,7 @@ static void pcmidi_setup_extra_keys(
>  		0
>  	};
>  
> -	unsigned int *pkeys = &keys[0];
> +	const unsigned int *pkeys = &keys[0];
>  	unsigned short i;

Applied, thanks for the fix.

-- 
Jiri Kosina
SUSE Labs
