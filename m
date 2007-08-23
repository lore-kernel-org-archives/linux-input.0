From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH V3 1/3] ACPI video hotkey: add new input key code for
	ACPI video hotkey events
Date: Thu, 23 Aug 2007 18:22:00 -0300
Message-ID: <20070823212200.GA17191@khazad-dum.debian.net>
References: <1187605427.2920.140.camel@acpi-hp.sh.intel.com> <200708231532.42908.lenb@kernel.org> <d120d5000708231310oeb4e365k3108ed55bc230bd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d120d5000708231310oeb4e365k3108ed55bc230bd1@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, mjg59@srcf.ucam.org, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com
List-Id: linux-input@vger.kernel.org

On Thu, 23 Aug 2007, Dmitry Torokhov wrote:
> On 8/23/07, Len Brown <lenb@kernel.org> wrote:
> > Thanks for the refreshed patch series, Rui.
> > I've added it to acpi-test.
> >
> > Still waiting on an ACK from Dmitry on the input.h definitions.
> 
> Sorry, I am still trying to recover from a hard drive failure...
> 
> The keycodes conflict with a pending patch adding KEY_BRL_DOT9 and
> KEY_BRL_DOT10 and so have to be moved somewhere else.

Also, this one:
+#define KEY_DISPLAY_CYCLE      0x1f9                                                                                                      

Should probably be
#define KEY_DISPLAY_CYCLE	KEY_SWITCHVIDEOMODE

According to what was explained to us (thinkpad-acpi and the other laptop
hotkey drivers).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
