From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v7 2/9] Input: goodix - reset device at init
Date: Thu, 08 Oct 2015 13:39:09 +0200
Message-ID: <1444304349.28661.4.camel@hadess.net>
References: <1444299575-17417-1-git-send-email-irina.tirdea@intel.com>
	 <1444299575-17417-3-git-send-email-irina.tirdea@intel.com>
	 <8618206.7jshXjkP9U@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8618206.7jshXjkP9U@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2015-10-08 at 12:54 +0200, Arnd Bergmann wrote:
> I think lists like this in drivers should be avoided if at all
> possible,
> it just leads to other people adding their platform in the lists as
> opposed to fixing their boot loaders.

Instructions on fixing UEFI firmwares without the sources welcome.
