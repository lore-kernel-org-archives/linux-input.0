From: Jason Gerecke <jason.gerecke@wacom.com>
Subject: Re: [PATCH] HID: rmi: fallback to generic/multitouch if hid-rmi is
 not built (was Re: [GIT PULL] HID for 4.11)
Date: Tue, 21 Feb 2017 16:53:11 -0800
Message-ID: <a6769863-f10c-6e5c-1034-45b2d620fa6a@wacom.com>
References: <alpine.LSU.2.20.1702201508280.24579@cbobk.fhfr.pm>
 <CA+55aFxLmgA7drrGfUJmCRPT-A74ROYf6GQHFGO5pzVjZ0dL7Q@mail.gmail.com>
 <CA+55aFzLGosGoB5STrAampHPQ9H-K7v08N2Jx9ETsHnMFgv+=A@mail.gmail.com>
 <CA+55aFzfUbcB44UYwbKv-qci-wxCsWKEZs4Mso-J5cCoz9x0qQ@mail.gmail.com>
 <alpine.LSU.2.20.1702211514540.24579@cbobk.fhfr.pm>
 <CA+55aFwbJDBMQi4nzcD8-cWUZ4S1jNAEYqo38_FinLJA4FfYCA@mail.gmail.com>
 <alpine.LSU.2.20.1702211644090.24579@cbobk.fhfr.pm>
 <CA+55aFyBkUWy+Qpm6XxyEUi-FU_YSj-r01aRLuh0qoTm_vSq9g@mail.gmail.com>
 <20170221174226.GB21560@mail.corp.redhat.com>
 <alpine.LSU.2.20.1702212159510.24579@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:48928
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753114AbdBVAxi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 19:53:38 -0500
In-Reply-To: <alpine.LSU.2.20.1702212159510.24579@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Ping Cheng <pinglinux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Tobita Tatsunosuke <tobita.tatsunosuke@wacom.co.jp>

One of the main reasons Wacom devices have historically required a
special driver is that the HID descriptors on their branded devices are
useless. A generic driver would only know the length of a report; no
information about the contents or layout is actually provided by the
hardware. The latest generation of Wacom tablets somewhat improves the
situation, but its still not good enough for the devices to be at all
useful with an e.g. hid-generic fallback. The hardware now provides a
full descriptor, but every usage is in a Vendor Defined usage page. We
can use Wacom's usage table definitions to implement "generic Wacom"
support for these new devices (which is exactly what we did in 4.10),
but no vendor-agnostic generic driver will understand the usages.

Wacom's embedded tablet PC sensors are a different story. These devices
*do* provide generic HID descriptors and it should be possible to have
hid-generic power them as a fallback. That said, it seems that Wacom is
moving away from their 0x56A vendor ID for these embedded sensors to a
new 0x2D1F vendor ID. This VID isn't recognized by any of the existing
Wacom kernel drivers and is (as I understand) intended be a way to allow
new hardware to work with the hid-generic driver.

Jason Gerecke, Linux Software Engineer
Wacom Technology Corporation
tel: 360-896-9833 ext. 229 (direct) / fax: 360-896-9724
http://www.wacom.com

On 02/21/2017 01:03 PM, Jiri Kosina wrote:
> On Tue, 21 Feb 2017, Benjamin Tissoires wrote: > >> Well, Wacom devices use to need a special driver, but the latest
>> generation should somewhat be able to work without a driver (IIRC).
>> > > I vaguely recall this wasn't the case at all for the older >
generations I've had my hands on, and it wasn't just the matter of >
HID_QUIRK_NO_INIT_REPORTS quirk. > > But anyway ... that wasn't reported
as a regression for quite some > time, so let's defer to what Ping and
Jason have to say regarding > protocol/driver compatibility. > > I'll be
pushing the RMI fix to Linus soon. > > Thanks, >


