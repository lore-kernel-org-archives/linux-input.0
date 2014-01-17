From: simon@mungewell.org
Subject: Re: [PATCH 2/4] HID: sony: Use standard output reports instead of
 raw reports to send data to the Dualshock 4.
Date: Fri, 17 Jan 2014 12:10:25 -0500
Message-ID: <da65806f5e5ea0f18f50f882ca569419.squirrel@mungewell.org>
References: <alpine.DEB.2.10.1401162134560.15779@franz-virtual-machine>
    <CANq1E4R3ryPDaivJE-TW=zBnOp9yD5+=-vpVP9zy9OACvud1yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:35094 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbaAQRK1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 12:10:27 -0500
In-Reply-To: <CANq1E4R3ryPDaivJE-TW=zBnOp9yD5+=-vpVP9zy9OACvud1yw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>


>> Use regular HID output reports instead of raw reports in the
>> dualshock4_state_worker function.  (Thanks Simon Mungewell)
>
> This description is actually wrong. hid_output_raw_report() is used
> for regular HID output reports. What you do, is using SET_REPORT to
> synchronously set output-reports. Anyhow, see below for comments.

Hi David,
Can you please confirm whether it is preferred to control the DS4 via
'hid_hw_request()' rather than 'hid_output_raw_report()'? They both appear
to work OK...

For the BT connected device we will have to use a different packet to a
different report.

Simon

