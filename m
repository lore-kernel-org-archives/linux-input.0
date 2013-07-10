From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] HID: fix data access in implement()
Date: Wed, 10 Jul 2013 14:11:07 +0200
Message-ID: <20130710141107.14bb5fe1@neptune.home>
References: <alpine.LNX.2.00.1307092042190.26857@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:33072 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab3GJMTH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jul 2013 08:19:07 -0400
In-Reply-To: <alpine.LNX.2.00.1307092042190.26857@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Gustavo Padovan <gustavo@padovan.org>, Adam Kropelin <akropel1@rochester.rr.com>, Grant Grundler <grundler@parisc-linux.org>, linux-input@vger.kernel.org

Hi Jiri,

Some notes regarding picoLCD part below.

On Tue, 09 July 2013 Jiri Kosina <jkosina@suse.cz> wrote:
> implement() is setting bytes in LE data stream. In case the data
> is not aligned to 64bits, it reads past the allocated buffer. It
> doesn't really change any value there (it's properly bitmasked), but
> in case that this read past the boundary hits a page boundary, pagefault
> happens when accessing 64bits of 'x' in implement(), and kernel oopses.
> 
> This happens much more often when numbered reports are in use, as the
> initial 8bit skip in the buffer makes the whole process work on values
> which are not aligned to 64bits.
> 
> This problem dates back to attempts in 2005 and 2006 to make implement()
> and extract() as generic as possible, and even back then the problem
> was realized by Adam Kroperlin, but falsely assumed to be impossible
> to cause any harm:
> 
>   http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg47690.html
> 
> I have made several attempts at fixing it "on the spot" directly in
> implement(), but the results were horrible; the special casing for processing
> last 64bit chunk and switching to different math makes it unreadable mess.
> 
> I therefore took a path to allocate a few bytes more which will never make
> it into final report, but are there as a cushion for all the 64bit math
> operations happening in implement() and extract().
> 
> All callers of hid_output_report() are converted at the same time to allocate
> the buffer by newly introduced hid_alloc_report_buf() helper.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/hid/hid-core.c            |   19 ++++++++++++++++++-
>  drivers/hid/hid-logitech-dj.c     |   12 ++++++++++--
>  drivers/hid/hid-picolcd_debugfs.c |   10 +++++++++-
>  drivers/hid/usbhid/hid-core.c     |    4 ++--
>  include/linux/hid.h               |    1 +
>  net/bluetooth/hidp/core.c         |   14 +++++++++-----
>  6 files changed, 49 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
> index 59ab8e1..784a17c 100644
> --- a/drivers/hid/hid-picolcd_debugfs.c
> +++ b/drivers/hid/hid-picolcd_debugfs.c
> @@ -394,7 +394,7 @@ static void dump_buff_as_hex(char *dst, size_t dst_sz, const u8 *data,
>  void picolcd_debug_out_report(struct picolcd_data *data,
>  		struct hid_device *hdev, struct hid_report *report)
>  {
> -	u8 raw_data[70];
> +	u8 *raw_data;
>  	int raw_size = (report->size >> 3) + 1;
>  	char *buff;
>  #define BUFF_SZ 256
> @@ -407,11 +407,18 @@ void picolcd_debug_out_report(struct picolcd_data *data,
>  	if (!buff)
>  		return;
>  
> +	raw_data = hid_alloc_report_buf(report, GFP_ATOMIC);
> +	if (!raw_data) {
> +		kfree(buff);
> +		return;
> +	}
> +
>  	snprintf(buff, BUFF_SZ, "\nout report %d (size %d) =  ",
>  			report->id, raw_size);
>  	hid_debug_event(hdev, buff);
>  	if (raw_size + 5 > sizeof(raw_data)) {

As you change raw_data from u8[] to u8* the sizeof(raw_data)
will not do the right thing.
In addition the whole test (if it were correct) is not needed anymore as
hid_alloc_report_buf() should always return a buffer of sufficient size.


So just drop the test:

-	if (raw_size + 5 > sizeof(raw_data)) {
-		kfree(buff);
-		hid_debug_event(hdev, " TOO BIG\n");
-		return;
-	} else {
-		raw_data[0] = report->id;
-		hid_output_report(report, raw_data);
-		dump_buff_as_hex(buff, BUFF_SZ, raw_data, raw_size);
-		hid_debug_event(hdev, buff);
-        }
+	raw_data[0] = report->id;
+	hid_output_report(report, raw_data);
+	dump_buff_as_hex(buff, BUFF_SZ, raw_data, raw_size);
+	hid_debug_event(hdev, buff);

>  		kfree(buff);
> +		kfree(raw_data);
>  		hid_debug_event(hdev, " TOO BIG\n");
>  		return;
>  	} else {
> @@ -644,6 +651,7 @@ void picolcd_debug_out_report(struct picolcd_data *data,
>  		break;
>  	}
>  	wake_up_interruptible(&hdev->debug_wait);
> +	kfree(raw_data);
>  	kfree(buff);
>  }
>  

Bruno
