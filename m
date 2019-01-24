From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] HID: elan: Make array buf static, shrinks object size
Date: Thu, 24 Jan 2019 16:54:28 +0000
Message-ID: <11666348-f50a-719f-89d6-d90b0a1ea8f7@canonical.com>
References: <20180926084150.17514-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926084150.17514-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

ping?

On 26/09/2018 09:41, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array buf on the stack but instead make it
> static. Makes the object code smaller by 43 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    7769	   1520	      0	   9289	   2449	drivers/hid/hid-elan.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    7662	   1584	      0	   9246	   241e	drivers/hid/hid-elan.o
> 
> (gcc version 8.2.0 x86_64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/hid/hid-elan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
> index 07e26c3567eb..05377eec2cb2 100644
> --- a/drivers/hid/hid-elan.c
> +++ b/drivers/hid/hid-elan.c
> @@ -393,7 +393,7 @@ static int elan_start_multitouch(struct hid_device *hdev)
>  	 * This byte sequence will enable multitouch mode and disable
>  	 * mouse emulation
>  	 */
> -	const unsigned char buf[] = { 0x0D, 0x00, 0x03, 0x21, 0x00 };
> +	static const unsigned char buf[] = { 0x0D, 0x00, 0x03, 0x21, 0x00 };
>  	unsigned char *dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
>  
>  	if (!dmabuf)
> 
