From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] HID: udraw: Add support for the uDraw tablet for PS3
Date: Tue, 15 Nov 2016 13:30:30 +0100
Message-ID: <1479213030.5750.18.camel@hadess.net>
References: <1478274223-3633-1-git-send-email-hadess@hadess.net>
          <alpine.LNX.2.00.1611081422170.29400@cbobk.fhfr.pm>
         <1478611807.2497.2.camel@hadess.net>
         <alpine.LNX.2.00.1611151207510.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1611151207510.29400@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2016-11-15 at 12:08 +0100, Jiri Kosina wrote:
> On Tue, 8 Nov 2016, Bastien Nocera wrote:
> 
> > In that particular case, I'd rather it got renamed to "hid-udraw-
> ps3"
> > in this case. The XBox 360 and Wii versions use completely
> different
> > protocols:
> > http://brandonw.net/udraw/
> > 
> > The XBox 360 version is more likely to be integrated in with other
> XBox
> > pads, and the Wii version along with other Wii Bluetooth remotes.
> 
> Makes the most sense to me. Could you please refresh the patch so
> that it 
> names the driver 'hid-udraw-ps3'? I'll then queue it for 4.10.

Sent as v3, thanks.
