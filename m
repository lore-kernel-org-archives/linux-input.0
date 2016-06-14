From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Kernel] Mainlining of Pyra nub joystick driver
Date: Tue, 14 Jun 2016 19:09:50 +0200
Message-ID: <DAA6B14A-062E-45E9-97DD-18D55480F0A8@goldelico.com>
References: <20160614114523.GC4820@zver> <20160614170206.GE4820@zver>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:26868 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbcFNRKe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 13:10:34 -0400
In-Reply-To: <20160614170206.GE4820@zver>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: linux-input@vger.kernel.org, devel@driverdev.osuosl.org, kernel-mentors@selenic.com, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Daniel Hung-yu Wu <hywu@google.com>, Moritz Fischer <moritz.fischer@ettus.com>, Geert Uytterhoeven <geert@linux-m68k.org>, S Twiss <stwiss.opensource@diasemi.com>, Rob Herring <robh@kernel.org>, Grant Grundler <grundler@chromium.org>


> Am 14.06.2016 um 19:02 schrieb Andrey Utkin <andrey_utkin@fastmail.com>:
> 
> On Tue, Jun 14, 2016 at 02:45:23PM +0300, Andrey Utkin wrote:
>> There's a pair of "nub" devices on Pyra handheld PC
>> ...
> 
> Update: found drivers/input/joystick/as5011.c in mainline kernel,
> will look how it works with as5013 hardware.

Before you spend too much time on it, they have not much in
common except the manufacturer and the as501x designation.

Register models (data sheet) are very different.

BR,
Nikolaus


