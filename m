From: Richard Nauber <richard.nauber@googlemail.com>
Subject: Re: [PATCH v2] HID: Fix reporting of nonexistent HWheel for Elecom
 BM084 (bluetooth mouse).
Date: Mon, 28 Jun 2010 19:11:23 +0200
Message-ID: <4C28D7BB.3000808@googlemail.com>
References: <4C288B57.7060600@googlemail.com> <20100628163451.GB11670@core.coreip.homeip.net> <alpine.LNX.2.00.1006281837090.13809@pobox.suse.cz> <4C28D3C1.7070307@googlemail.com> <alpine.LNX.2.00.1006281900440.13809@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53991 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0F1RLj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 13:11:39 -0400
Received: by fxm14 with SMTP id 14so859126fxm.19
        for <linux-input@vger.kernel.org>; Mon, 28 Jun 2010 10:11:38 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1006281900440.13809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On 06/28/2010 07:01 PM, Jiri Kosina wrote:
> On Mon, 28 Jun 2010, Richard Nauber wrote:
> 
>> Ok, how about this:
> [ ... snip ... ]
>> +static void elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>> +		unsigned int rsize)
>> +{
>> +	if (rsize >= 48 && rdesc[46] == 0x05 && rdesc[47] == 0x0c) {
>> +		dev_info(&hdev->dev, "Fixing up Elecom BM084 "
>> +				"report descriptor.\n");
>> +		rdesc[47] = 0x00;
>> +	}
>> +}
>> +
>> +static const struct hid_device_id elecom_devices[] = {
>> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084)},
>> +	{ } heads up and

> What is this? :)

Whops, I was looking for that phrase. It is probably missing in an other message :)
 
> I will fix that mess up and apply to my tree.

Thanks for that,
Richard
