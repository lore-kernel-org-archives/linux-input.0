From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: udraw: Add support for the uDraw tablet for
 PS3
Date: Tue, 15 Nov 2016 12:08:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611151207510.29400@cbobk.fhfr.pm>
References: <1478274223-3633-1-git-send-email-hadess@hadess.net>  <alpine.LNX.2.00.1611081422170.29400@cbobk.fhfr.pm> <1478611807.2497.2.camel@hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478611807.2497.2.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 8 Nov 2016, Bastien Nocera wrote:

> In that particular case, I'd rather it got renamed to "hid-udraw-ps3"
> in this case. The XBox 360 and Wii versions use completely different
> protocols:
> http://brandonw.net/udraw/
> 
> The XBox 360 version is more likely to be integrated in with other XBox
> pads, and the Wii version along with other Wii Bluetooth remotes.

Makes the most sense to me. Could you please refresh the patch so that it 
names the driver 'hid-udraw-ps3'? I'll then queue it for 4.10.

Thanks,

-- 
Jiri Kosina
SUSE Labs
