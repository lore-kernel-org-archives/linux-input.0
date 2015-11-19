From: "Wan, Vincent" <Vincent.Wan@amd.com>
Subject: RE: [PATCH] input: i8042: add quirk to implement i8042 detect for AMD
Date: Thu, 19 Nov 2015 14:40:54 +0000
Message-ID: <DM3PR1201MB1023A0F662136FC697351923E61B0@DM3PR1201MB1023.namprd12.prod.outlook.com>
References: <1445002020-12672-1-git-send-email-Vincent.Wan@amd.com>
 <20151016085808.GA32193@pd.tnic>
 <CAKT61h95dJjXUx9cp5kCqOvsEMQBbYZqhnoUfQbf1bJqVKi7jQ@mail.gmail.com>
 <20151016102155.GD31612@pd.tnic> <20151017163847.GB13470@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0090.outbound.protection.outlook.com ([207.46.100.90]:53248
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756066AbbKSPOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 10:14:24 -0500
In-Reply-To: <20151017163847.GB13470@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Wan, Vincent" <Vincent.Wan@amd.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>

> Subject: Re: [PATCH] input: i8042: add quirk to implement i8042 detect for AMD
> 
> On Fri, Oct 16, 2015 at 12:21:55PM +0200, Borislav Petkov wrote:
> > On Fri, Oct 16, 2015 at 05:35:40PM +0800, Wan ZongShun wrote:
> > > 2015-10-16 16:58 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> > > > On Fri, Oct 16, 2015 at 09:27:00AM -0400, Vincent Wan wrote:
> > > >> Detecting platform supports i8042 or not, AMD resorted to BIOS's
> > > >> FADT i8042 flag.
> > > >>
> > > >> Signed-off-by: Vincent Wan <Vincent.Wan@amd.com>
> > > >> ---
> > > >>  drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
> > > >>  1 file changed, 6 insertions(+)
> > >
> > > >>  /*
> > > >> @@ -1047,6 +1048,11 @@ static int __init i8042_platform_init(void)
> > > >>       /* Just return if pre-detection shows no i8042 controller exist */
> > > >>       if (!x86_platform.i8042_detect())
> > > >>               return -ENODEV;
> > > >> +
> > > >> +     if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> > > >
> > > > Why the vendor check if you're accessing a bit defined in the ACPI spec?
> > >
> > > From intel's 'x86_platform.i8042_detect' implementation, I doubt if
> > > their BIOS is providing this i8024 flag.
> >
> > Why would you doubt that - it is at least in ACPI v4, if not earlier.
> > If you still doubt that, go and check it or ask Intel people.
> >
> > > So I have to implement my codes carefully.
> >
> > What are you people talking about?!
> >
> > It is in the ACPI spec - this bit is either set or not. If it is not
> 
> Well, the fact that is is in a spec does not mean that vendors follow it (and
> BTW I do not think that AMD as a CPU vendor can vouch for a random notebook
> or desktop vendor that acquired and then hacked on some version of some BIOS
> from some BIOS vendor so I agree that this check is a no-go).
> 
> Historically we did not trust BIOS data with regard to i8042 on x86.
> Maybe we should now using certain date cutoff (anything manufactured past
> 201[2345?]).
> 
> Does Windows respect this flag? If it does then we could also trust it, and not
> only on AMD but for all x86 CPUs.

Dmitry ,I found a document in MS MSDN, link:

http://download.microsoft.com/download/3/2/c/32cb69db-71e3-447e-a91b-4070cdc4548a/WLP22-10_a.doc

I copy a piece of comments from this doc here, seems MS is requiring this flag for legacy free system from BIOS.
If you think it is ok, I will send v2 patch later to add detect function for all x86 CPUs.

"
A4.1 - Legacy-Free PC System - Windows Compatibility
A4.1.1 - ACPI legacy-free support is reported as described in "ACPI Changes for Legacy Free" 
Any x86-based system designs that reduce the amount of legacy ISR support in conjunction with other legacy removal efforts (such as 8042 removal) must still provide the necessary ISRs required to boot systems using BIOS. The minimum requirements include support for ISR 8h, 13h, and 19h (all functions), and ISR 15h, function E820h.
To achieve this, Fixed ACPI Description Table (FADT) settings must be supported and correctly implemented, including support for reporting legacy-free and hard reset/boot capabilities, as described in the specification at http://go.microsoft.com/fwlink/?LinkId=36697
*	A4.1.1.1 LEGACY_DEVICES flag is set to 0 in the ACPI FADT as defined in ACPI section 5.2.1.
*	A4.1.1.2 ACPI reset mechanism as defined in ACPI section 4.7.5.
*	A4.1.1.3 8042 flag is set to 0 in systems that do not include an 8042 controller; value is set to 1 in a mobile or desktop system that includes an 8042 controller. 
*	A4.1.1.4 Debug Port Table in the BIOS, as described in ACPI section 5.2.11.
"
> 
> Thanks.
> 
> --
> Dmitry
