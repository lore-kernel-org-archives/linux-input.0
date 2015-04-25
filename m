From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 2/2] Input - synaptics: pin 3 touches when the firmware
 reports 3 fingers
Date: Sat, 25 Apr 2015 11:40:30 +0200
Message-ID: <553B610E.2000500@bitmath.org>
References: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com> <1429717509-27396-3-git-send-email-benjamin.tissoires@redhat.com> <20150423163818.GC34808@dtor-ws> <20150423184825.GB10937@mail.corp.redhat.com> <20150424225049.GA14791@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay6.public.one.com ([91.198.169.200]:49992 "EHLO
	mailrelay6.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758757AbbDYJk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Apr 2015 05:40:28 -0400
In-Reply-To: <20150424225049.GA14791@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Hans de Goede <hdegoede@redhat.com>

Benjamin,

>>>> For old kernels this is not a problem because max_slots was 2 and libinput/
>>>> xorg-synaptics knew how to deal with that. Now that max_slot is 3, the
>>>> clients ignore BTN_TOOL_TRIPLETAP and count the actual used slots (so 2).
>>>> It then gets confused when receiving the BTN_TOOL_TRIPLETAP and DOUBLETAP
>>>> information, and goes wild.

Maybe the cr48 sensor should be classified as MT_SEMI instead.

Henrik

