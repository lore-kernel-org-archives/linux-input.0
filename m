From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v8 2/4] i2c-smbus: add SMBus Host Notify support
Date: Mon, 18 Jul 2016 18:47:12 +0200
Message-ID: <20160718184712.4ad7ce58@endymion>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
	<1465484030-28838-3-git-send-email-benjamin.tissoires@redhat.com>
	<20160718113721.2eaa86d3@endymion>
	<20160718155902.GS4663@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20160718155902.GS4663@mail.corp.redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 18 Jul 2016 17:59:02 +0200, Benjamin Tissoires wrote:
> On Jul 18 2016 or thereabouts, Jean Delvare wrote:
> > You provide stubs for SMBus Host Notify support if CONFIG_I2C_SMBUS is
> > not selected. There are no such stubs for SMBus Alert support, for which
> > I assumed drivers would select I2C_SMBUS if they have support. Which is
> > what you are actually doing for i2c-i801 in a latter patch.
> > 
> > Is there any reason for this difference? For consistency I'd rather
> > provide stubs for all or none. My preference being for none, unless you
> > have a use case which requires them.
> 
> Looks like you are right. There is no need for the stubs and they can be
> dropped. I think I had them in the first place for a previous
> implementation, and they just stayed here.
> 
> Given that you already sent a few cleanup patches, do you want to send
> this fix also, or do you expect me to send it? (I don't think there will
> be a conflict, so either is fine).

I can do it, I just wanted to make sure it was OK with you first.

-- 
Jean Delvare
SUSE L3 Support
