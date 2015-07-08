From: Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH] HID: cp2112: fix to force single data-report reply
Date: Wed, 8 Jul 2015 11:15:43 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507081115220.10183@pobox.suse.cz>
References: <1434867625-3062-1-git-send-email-borneo.antonio@gmail.com> <55939F3E.7070505@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55939F3E.7070505-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 1 Jul 2015, Ellen Wang wrote:

> Works as described.  Thank you!
> 
> By the way, I tested the code with and without your fix on my rev 2 chip, and
> it behaved the same way as you describe on your rev 1 chip.

Ellen, are you okay with me applying the patch with

	Tested-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>

?

Thanks,

-- 
Jiri Kosina
SUSE Labs
