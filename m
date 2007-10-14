From: Arjan Opmeer <arjan@opmeer.net>
Subject: Re: First stab at Elantech touchpad driver for 2.6.22.6. Testers
	wanted!
Date: Sun, 14 Oct 2007 03:14:40 +0200
Message-ID: <20071014011440.GB15877@adopmeer.homeip.net>
References: <20070914000015.GA20527@adopmeer.homeip.net> <d120d5000710091301h790db3c4nc44e71551a4bc408@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000710091301h790db3c4nc44e71551a4bc408@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Hi Dmitry,

On Tue, Oct 09, 2007 at 04:01:58PM -0400, Dmitry Torokhov wrote:
> On 9/13/07, Arjan Opmeer <arjan@opmeer.net> wrote:
> >
> > This is a first stab at a Linux driver for the Elantech touchpad as
> > found on some laptops (e.g. MSI MS-1035 aka L725).
> 
> Since the touchpad supports absolute mode I'd recommend removing
> support for extended relative mode and concentrating on making
> absolute mode work so that Synaptics X driver can be used with this
> touchpad as well.

Well, from the few reports I got it seems not all Elantech touchpads are
created equal. And as we don't have any documentation on these touchpads I
really don't know whether they all support absolute mode, have the same
parameters or use the same protocol for it.

So for the time being I really would like to keep support for absolute as
well as relative mode in to make it easier for users to switch and test and
find out and report where thing go wrong.

Maybe that once we find out more about these touchpads and the possible
different version we can focus on a solution that will fit all. But let's
not do it while users are still trying whether the driver works for them at
all... :)


Arjan
