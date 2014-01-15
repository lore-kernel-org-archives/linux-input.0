From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
Date: Wed, 15 Jan 2014 19:20:22 +0100
Message-ID: <4773460.bSrjnYju7q@wuerfel>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
 <201401151736.46280.arnd@arndb.de> <20140115174519.GE17530@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140115174519.GE17530@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Ian Campbell <ijc@hellion.org.uk>, Gregory Clement <gregory.clement@free-electrons.com>, tbm@cyrius.com
List-Id: linux-input@vger.kernel.org

On Wednesday 15 January 2014 18:45:19 Andrew Lunn wrote:
> > > But i'm also a little bit concerned by the "unique number" and this
> > > ending up in /dev/input/by-path/platform-gpio_keys.3-event. Is this
> > > path supposed to be stable? This unique number is not stable. An
> > > unwitting change to the DT could cause its value to change. Do we need
> > > to make it stable?
> > > 
> > 
> > One possibility would be to create an artificial bus in DT for all
> > gpio-keys devices, use #address-cells=<1> and #size-cells=<0>
> > for it, and give each device a unique reg property. Not sure if that
> > would be considered an elegant solution though.
> 
> Hi Arnd
> 
> Can i imply from your answer that you think 
> 
> /dev/input/by-path/platform-gpio_keys.3-event
> 
> should be stable?

No, I have no idea whether it should be or not. I was just trying
to come up with a way to make it stable if that's desired.

> A quick look at udev rules seems to suggestion this is an issue for
> input/gpio-keys and maybe audio and video if there is a top level DT
> property collecting the different sub devices together for ASOC and
> V4L.

For some other subsystems, we have entries in /aliases/ to sort
them. Maybe that would work here to get a stable path independent
of the location in DT.

	Arnd
