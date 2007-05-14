From: "Giel de Nijs" <giel@caffeinetrip.com>
Subject: Re: [patch 0/2] [PATCH] input: correctly handle keys without hardware release event
Date: Mon, 14 May 2007 08:16:29 +0200
Message-ID: <929318d30705132316w300fe8e4ue98a02e85cd82cfb@mail.gmail.com>
References: <20070511172326.008944330@caffeinetrip.com>
	 <200705132344.19311.dtor@insightbb.com>
Reply-To: giel@caffeinetrip.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200705132344.19311.dtor@insightbb.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Matt Domsch <matt_domsch@dell.com>, Rezwanul Kabir <rezwanul_kabir@dell.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 5/14/07, Dmitry Torokhov <dtor@insightbb.com> wrote:

> > This patch adds a soft release key mask to input_dev, to enable keyboard
> > drivers to determine which keys never generate a hardware release event and
> > hence add a release event after every press event of such keys. The mask is
> > controlled by ioctls.
>
> I don't think we want to add all the infrastructure for the benefit of single
> driver. Can we add a quirk to atkbd and activate it based on DMI?

As the atkbd.c driver already had a work-around for exactly the same problem
with some (I think) Korean keyboards (KEY_HANGEUL and KEY_HANJA), adding
this infrastructure (well, one pointer and two ioctls) seemed a logical step.
If you prefer a hack just in atkbd.c and activate it on Dell laptops, I see
what I can do. The problem with that is that I don't know the scancodes of
all keys on all models (and future models) that exhibit this behaviour. I'll
implement what I know, though (it'll take some time because I'll be
travelling quite a lot very soon).

Greetings,
Giel
