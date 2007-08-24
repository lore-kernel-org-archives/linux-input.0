From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V3 1/3] ACPI video hotkey: add new input key code for ACPI video hotkey events
Date: Thu, 23 Aug 2007 21:49:08 -0400
Message-ID: <200708232149.09015.lenb@kernel.org>
References: <1187605427.2920.140.camel@acpi-hp.sh.intel.com> <d120d5000708231310oeb4e365k3108ed55bc230bd1@mail.gmail.com> <20070823212200.GA17191@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070823212200.GA17191@khazad-dum.debian.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, mjg59@srcf.ucam.org, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com
List-Id: linux-input@vger.kernel.org

On Thursday 23 August 2007 17:22, Henrique de Moraes Holschuh wrote:
> On Thu, 23 Aug 2007, Dmitry Torokhov wrote:
> > On 8/23/07, Len Brown <lenb@kernel.org> wrote:
> > > Thanks for the refreshed patch series, Rui.
> > > I've added it to acpi-test.
> > >
> > > Still waiting on an ACK from Dmitry on the input.h definitions.
> > 
> > Sorry, I am still trying to recover from a hard drive failure...
> > 
> > The keycodes conflict with a pending patch adding KEY_BRL_DOT9 and
> > KEY_BRL_DOT10 and so have to be moved somewhere else.
> 
> Also, this one:
> +#define KEY_DISPLAY_CYCLE      0x1f9                                                                                                      
> 
> Should probably be
> #define KEY_DISPLAY_CYCLE	KEY_SWITCHVIDEOMODE
> 
> According to what was explained to us (thinkpad-acpi and the other laptop
> hotkey drivers).

I agree.  I noticed this also
and I'll send a refreshed patch shortly.

thanks,
-Len
