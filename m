From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2 4/4] da850-evm: add baseboard UI expander buttons,
 switches and LEDs
Date: Mon, 22 Nov 2010 17:30:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302477EB2D8@dbde02.ent.ti.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
	<d6d59b4a3c34149008f3681e0d6106efa15f354d.1289935504.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EAA89@dbde02.ent.ti.com>
 <AANLkTike4sRvptEe9PXLT2u+SrFMOpNC6pvLPSzBfVOX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTike4sRvptEe9PXLT2u+SrFMOpNC6pvLPSzBfVOX@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>
List-Id: linux-input@vger.kernel.org

Hi Ben,

On Fri, Nov 19, 2010 at 21:10:50, Ben Gardiner wrote:

> >> [...]
> >
> > How does gpio_request prevent sysfs control?
>
> To obtain access to a gpio through the sysfs interface the user must
> first write the gpio number to 'export'. When the gpio has been
> gpio_request()'d the result of writing to 'export' is nothing; whereas
> writing to export would normally result in the appearance of a named
> gpio line alongside 'export'.
>
>  I hope the following commands and their output illustrate my point:
>
> $ cd /sys/class/gpio/
> $ ls
> export       gpiochip128  gpiochip160  gpiochip64   unexport
> gpiochip0    gpiochip144  gpiochip32   gpiochip96
> $ echo 160 > export
> $ ls
> export       gpiochip128  gpiochip160  gpiochip64   unexport
> gpiochip0    gpiochip144  gpiochip32   gpiochip96
> $ echo 163 > export
> $ ls
> export       gpiochip128  gpiochip160  gpiochip64   tp_22
> gpiochip0    gpiochip144  gpiochip32   gpiochip96   unexport

Thanks for the explanation. I should have probably asked
earlier, why do we need to prevent sysfs access of
deep sleep enable and sw reset pins? We don't seem to be
using them in the kernel either.

Thanks,
Sekhar
