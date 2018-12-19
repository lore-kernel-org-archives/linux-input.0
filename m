From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: debug: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Wed, 19 Dec 2018 14:21:50 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1812191421360.17216@cbobk.fhfr.pm>
References: <20181201024951.5508-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181201024951.5508-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 30 Nov 2018, Yangtao Li wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/hid/hid-debug.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index b48100236df8..c530476edba6 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -1072,11 +1072,6 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
>  	return 0;
>  }
>  
> -static int hid_debug_rdesc_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, hid_debug_rdesc_show, inode->i_private);
> -}
> -
>  static int hid_debug_events_open(struct inode *inode, struct file *file)
>  {
>  	int err = 0;
> @@ -1211,12 +1206,7 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -static const struct file_operations hid_debug_rdesc_fops = {
> -	.open           = hid_debug_rdesc_open,
> -	.read           = seq_read,
> -	.llseek         = seq_lseek,
> -	.release        = single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(hid_debug_rdesc);

Applied to hid.git#for-4.21/core. Thanks,

-- 
Jiri Kosina
SUSE Labs
