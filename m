From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Making KEY_UNKNOWN really useful to userland
Date: Thu, 31 May 2007 10:37:22 -0400
Message-ID: <d120d5000705310737qc62504duac4a1a1494852c42@mail.gmail.com>
References: <20070527121513.GC19562@khazad-dum.debian.net>
	 <20070529130528.GB12935@khazad-dum.debian.net>
	 <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com>
	 <20070530152444.GD17530@khazad-dum.debian.net>
	 <d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com>
	 <20070530172420.GA6883@khazad-dum.debian.net>
	 <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com>
	 <20070531005305.GC6883@khazad-dum.debian.net>
	 <1180607825.2693.17.camel@localhost.localdomain>
	 <20070531124842.GC6299@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070531124842.GC6299@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 5/31/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> On Thu, 31 May 2007, Richard Hughes wrote:
>
> I am on it on the thinkpad-acpi side, so at least for that, you don't have
> to worry.  I am still waiting an answer about which event is the correct one
> to output scancodes, but the thinkpad-acpi GIT tree is already updated with
> the above, tentively using MSC_SCAN to report scan codes.
>

I thought I sent out email saying MSC_SCAN is what you want to use,
MSC_RAW is raw data from device, potentially having make/break codes
included/encoded. Apparently my mail broke even more than I thought.

Highjacking the thread somewhat - Richard, I saw your patch for
toshiba_acpi. Please use input-polldev to set up polled devices. It
will create work queue for you and will make sure that polling is
stopped when device is closed. Also I don't think you want to use
KEY_BREAK. What is the expected function of that key?

Please copy me on input-related changes in the tree. Thank you.

-- 
Dmitry
