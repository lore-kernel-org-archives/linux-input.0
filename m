From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] Input - surface3_spi: add new driver for the Surface
 3
Date: Tue, 17 May 2016 19:45:42 +0200
Message-ID: <1463507142.3440.8.camel@hadess.net>
References: <1463480179-11974-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463480179-11974-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2016-05-17 at 12:16 +0200, Benjamin Tissoires wrote:
> This is a basic driver for the Surface 3. I am not so sure it will
> work
> with any firmwares as most values are encoded, but given that I only
> have
> access to my current device with its firmware and I don't have the
> datasheet, it should be OK for now.
> 
> The Surface Pen is not supported (if it is supposed to be). I'll work
> on
> this when I get one.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Works with up to 10 touches (I don't have any more fingers) and seems
to do palm detection as well.

Tested-by: Bastien Nocera <hadess@hadess.net>
