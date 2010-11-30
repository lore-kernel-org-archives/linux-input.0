From: "pascal@pabr.org" <pascal@pabr.org>
Subject: Re: hidp_output_raw_report, HID_OUTPUT_REPORT and Sixaxis
Date: Tue, 30 Nov 2010 18:40:03 +0100
Message-ID: <id3cua$12v$2@dough.gmane.org>
References: <20101130145405.d8142bc3.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59052 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716Ab0K3RpG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 12:45:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1PNUGG-0001Na-Ic
	for linux-input@vger.kernel.org; Tue, 30 Nov 2010 18:45:04 +0100
Received: from rob92-6-82-231-243-221.fbx.proxad.net ([82.231.243.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 30 Nov 2010 18:45:04 +0100
Received: from pascal by rob92-6-82-231-243-221.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 30 Nov 2010 18:45:04 +0100
In-Reply-To: <20101130145405.d8142bc3.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Antonio Ospite wrote:
> +++ b/net/bluetooth/hidp/core.c
>  	case HID_OUTPUT_REPORT:
> -		report_type = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
> +		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;

> Is it only the Sixaxis which needs the output report as a SET_REPORT
> operation, or the change above is an actual fix?

My understanding of the Bluetooth HID Profile specification [1],
section 7.4.9, is that on the control channel DATA is only for
responding to an incoming GET_REPORT.  Since Linux is the HID
Host, it will probably never need to reply to a GET_REPORT.
So your patch looks good.

Note that usbhid_output_raw_report() seems to send OUTPUT
reports as USB interrupt messages and FEATURE reports as
USB SET_REPORT control messages, which makes sense too.
It would be nice if hidraw behaved the same over USB and
over Bluetooth.  Unfortunately I don't think you can drive
the sixaxis leds with DATA on the Bluetooth interrupt channel.

Pascal

[1] http://www.bluetooth.com/Specification%20Documents/HID_SPEC_V10.pdf

