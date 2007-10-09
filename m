From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: First stab at Elantech touchpad driver for 2.6.22.6. Testers wanted!
Date: Tue, 9 Oct 2007 16:01:58 -0400
Message-ID: <d120d5000710091301h790db3c4nc44e71551a4bc408@mail.gmail.com>
References: <20070914000015.GA20527@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754912AbXJIUCV@vger.kernel.org>
In-Reply-To: <20070914000015.GA20527@adopmeer.homeip.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Arjan,

On 9/13/07, Arjan Opmeer <arjan@opmeer.net> wrote:
>
> Hi!,
>
> This is a first stab at a Linux driver for the Elantech touchpad as found on
> some laptops (e.g. MSI MS-1035 aka L725).
>

This is great! Thank you very much for your effort.

Since the touchpad supports absolute mode I'd recommend removing
support for extended relative mode and concentrating on making
absolute mode work so that Synaptics X driver can be used with this
touchpad as well.

-- 
Dmitry
