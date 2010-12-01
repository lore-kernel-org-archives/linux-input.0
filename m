From: "pascal@pabr.org" <pascal@pabr.org>
Subject: Re: hidp_output_raw_report, HID_OUTPUT_REPORT and Sixaxis
Date: Wed, 01 Dec 2010 23:40:37 +0100
Message-ID: <id6itu$i3q$1@dough.gmane.org>
References: <20101130145405.d8142bc3.ospite@studenti.unina.it>	<id3cua$12v$2@dough.gmane.org> <20101201220635.ccba6b58.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47322 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755941Ab0LAWlP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Dec 2010 17:41:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1PNvMQ-00046a-EY
	for linux-input@vger.kernel.org; Wed, 01 Dec 2010 23:41:14 +0100
Received: from rob92-6-82-231-243-221.fbx.proxad.net ([82.231.243.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 01 Dec 2010 23:41:14 +0100
Received: from pascal by rob92-6-82-231-243-221.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 01 Dec 2010 23:41:14 +0100
In-Reply-To: <20101201220635.ccba6b58.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Antonio Ospite wrote:
> The non-standard USB behavior made me think that the patch proposed
> could not be an actual fix but another non-standard sixaxis quirk;

That sounds right; I hadn't noticed hid-sony.c overriding
usbhid_output_raw_report().  Maybe it should simply override
hidp_output_raw_report() as well.

And maybe the default hidp_output_raw_report() should be
patched to behave like the default usbhid_output_raw_report(),
for the sake of consistency.

I am not sure you will find a final answer in the HID spec, but
the default usbhid_output_raw_report() certainly makes sense:
Send OUTPUT reports as interrupt messages because this is more
efficient e.g. for streaming reports to force-feedback devices;
and use the control channel only when the spec leaves no other
choice, i.e. for other report types.

Of course there is also the option of adding a specific function
in struct hid_device for transactions on the control channel.
That would be a good opportunity to enforce section 7.9.1
("no more than one outstanding request on the control channel")
and to implement callbacks for handshake results; but currently
nobody needs these features AFAIK.

Pascal

