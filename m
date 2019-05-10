From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
Date: Fri, 10 May 2019 10:57:22 +0200
Message-ID: <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
         <20190407133037.0ad98897@archlinux>
         <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
         <20190414124029.1f1f6084@archlinux>
         <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com>
         <20190422152014.7c6637ab@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422152014.7c6637ab@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-input@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2019-04-22 at 15:20 +0100, Jonathan Cameron wrote:
> > Different goals usually lead to different solution architectures.
> 
> Indeed, but in this case we have your proposal which is a subset of
> what
> I am suggesting.  One architecture can fulfil both requirements.
> 
> I'll leave it for the other thread, but Bastien has raised the case
> (that I'd forgotten) that there already userspace stacks that are
> capable of happily taking in both IIO and Input devices.  The
> confusion
> here is they will now discover 'both' without the existing userspace
> knowing that they are the same device.  We need to be very careful
> not
> to break those userspace programs.
> 
> So this is an illustration of why the simplistic case doesn't work
> 'now'.

I don't know what state the whole patch is, but, at the very least, I'd
expect that patch to export the fact that it's exporting synthesised
data from another driver, so that it can be easily ignored in user-
space that already supports IIO devices.
