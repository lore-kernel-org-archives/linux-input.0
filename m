From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [HP Jornada 6XX] - Onboard Keyboard support
Date: Mon, 30 Jul 2007 08:39:20 -0400
Message-ID: <d120d5000707300539haa26ae8sdfee043ae9e64688@mail.gmail.com>
References: <20070721181549.9d118414.Kristoffer.Ericson@Gmail.com>
	 <200707220145.10563.dtor@insightbb.com>
	 <20070726223452.e6d8f7c3.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070726223452.e6d8f7c3.Kristoffer.Ericson@Gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Kristoffer,

On 7/27/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> Dmitry,
>
> Ive merged scan_keyb and started to minimize it for just one keyboard, just want to hear from you if this is an acceptable approach.
> Its a work in progress, just want to know if im on the right path.
>

Like I said, please look at input-polldev
(drivers/input/input-polldev.c). It takes care of setting up workqueue
used for polling and will only poll if there are users so the driver
only needs to provide miplementation of scan function. Take a look at
drivers/input/keyboard/aaed2000_kbd.c to see how it is used.

-- 
Dmitry
