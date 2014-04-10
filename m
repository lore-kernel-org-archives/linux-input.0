From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH resend 2/2] input/serio/8042: Add firmware_id support
Date: Thu, 10 Apr 2014 11:02:17 +0200
Message-ID: <53465E19.1060705@redhat.com>
References: <1397033270-29597-1-git-send-email-hdegoede@redhat.com> <1397033270-29597-3-git-send-email-hdegoede@redhat.com> <20140409182434.GA25308@core.coreip.homeip.net> <20140409182926.GB3196@srcf.ucam.org> <20140409200923.GA25808@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54332 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934647AbaDJJC0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Apr 2014 05:02:26 -0400
In-Reply-To: <20140409200923.GA25808@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

Hi,

On 04/09/2014 10:09 PM, Dmitry Torokhov wrote:
> On Wed, Apr 09, 2014 at 07:29:26PM +0100, Matthew Garrett wrote:
>> On Wed, Apr 09, 2014 at 11:24:34AM -0700, Dmitry Torokhov wrote:
>>
>>> Do we need all IDs? I'd expect we only interested in HID, not CIDs?
>>
>> I think HID handles the cases we've seen so far, but we could imagine a 
>> system vendor providing their own HID, a trackpad vendor's CID and then 
>> the generic mouse CID. It seems better to err on the side of including 
>> them.
> 
> OK, fair enough. Another question - do we want to prefix IDs with "PNP:"
> prefix so that if we add device tree in the future we'll know what kind
> of IDs we are dealing with?

I'm a bit divided on this, adding a "PNP: " prefix will make it a bit harder
to parse, OTOH once we will have other users like devicetree knowing where
the info comes from will be very useful. To me in the end the latter argument
wins. Let me know if you agree and I'll do a v3 adding the PNP: prefix.

Regards,

Hans
