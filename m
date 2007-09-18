From: aherrman@arcor.de
Subject: Re: [PATCH] sony-laptop/thinkpad-acpi: fix build error
Date: Tue, 18 Sep 2007 21:53:31 +0200
Message-ID: <20070918195331.GA5279@devil>
References: <20070917205434.GA22458@devil> <200709181249.14909.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200709181249.14909.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, Sep 18, 2007 at 12:49:14PM -0400, Len Brown wrote:
> 
> I'd prefer to use "depends on" here, as "select" is sort
> of a last resort, given its inherent disfunctionalty
> (is that a word?:-)

Yes, select is evil as it does not take care of "select" and
"depends on" statements of the selected config option.

> yes, I wish "select" worked the way programmers want it to,
> but it doesn't.  Indeed, the only reason using it here is technically
> correct is that both these invocations depends on X86 and that
> avoids the conflict with !s390 INPUT.

Hmm, wasn't especially aware of that.

> Also, the reality is that all configs that want these drivers
> will have INPUT set already -- something that probably could
> not be said of BACKLIGHT_CLASS_DEVICE etc. -- so this patch
> is really just to please randconfig.

Right you are. Randconfig found that one.

> Unless you object, I'll just change this to "depends on" when i apply it.

No, I don't object.


Regards,

Andreas

