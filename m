From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v1] HID: bug fixes in hid-cp2112 driver
Date: Thu, 23 Apr 2015 23:47:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504232346530.3695@pobox.suse.cz>
References: <1429143746-16967-1-git-send-email-ellen@cumulusnetworks.com> <20150416074158.GA913@katana> <552F73A8.5060605@cumulusnetworks.com> <20150422080327.GG1511@katana> <5539681B.2030700@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5539681B.2030700-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 23 Apr 2015, Ellen Wang wrote:

> I've separated out the cp2112_i2c_xfer() bug fix from the patch.  Should I
> submit it as v2 or a new patch altogether?

Please submit this as a completely new series, obsoleting the previous 
patch.

Thanks,

-- 
Jiri Kosina
SUSE Labs
