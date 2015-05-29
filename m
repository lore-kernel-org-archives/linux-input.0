From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v1] HID: support multiple and large i2c transfers in
 hid-cp2112
Date: Fri, 29 May 2015 16:54:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505291654210.26271@pobox.suse.cz>
References: <1429825766-19594-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429825766-19594-1-git-send-email-ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 23 Apr 2015, Ellen Wang wrote:

> cp2112_i2c_xfer() only supports a single i2c_msg and only
> reads up to 61 bytes.  More than one message at a time
> and longers reads just return errors.
> 
> This is a serious limitation.  For example, the at24 eeprom driver
> generates paired write and read messages (for eeprom address and data).
> And the reads can be quite large.  The fix consists of a loop
> to go through all the messages, and a loop around cp2112_read()
> to pick up all the returned data.  For extra credit, it now also
> supports write-read pairs and implements them as
> CP2112_DATA_WRITE_READ_REQUEST.
> 
> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>

David, could you please provide your Reviewed-by: / Acked-by: for this 
patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs
