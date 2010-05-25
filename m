From: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH v3] powerpc: Add i8042 keyboard and mouse irq parsing
Date: Tue, 25 May 2010 13:19:57 -1000
Message-ID: <4BFC5B1D.6060007@firmworks.com>
References: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<AANLkTikve-ZghgpVl3cyjjgWAch-oCJ0EiYK2127f5gS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <AANLkTikve-ZghgpVl3cyjjgWAch-oCJ0EiYK2127f5gS-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Martyn Welch <martyn.welch-JJi787mZWgc@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Grant Likely wrote:
> On Tue, May 25, 2010 at 2:09 AM, Martyn Welch <martyn.welch-JJi787mZWgc@public.gmane.org> wrote:
>   
>> Currently the irqs for the i8042, which historically provides keyboard and
>> mouse (aux) support, is hardwired in the driver rather than parsing the
>> dts.  This patch modifies the powerpc legacy IO code to attempt to parse
>> the device tree for this information, failing back to the hardcoded values
>> if it fails.
>>
>> Signed-off-by: Martyn Welch <martyn.welch-JJi787mZWgc@public.gmane.org>
>> ---
>>
>> v2: This patch no longer requires the DTS files to be modified, reading the
>> interrupts from the current location as suggested by Grant.
>>
>> v3: Code compacted as suggested by Grant.
>>
>>  arch/powerpc/kernel/setup-common.c |   13 +++++++++++++
>>  drivers/input/serio/i8042-io.h     |    5 +++++
>>  2 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 48f0a00..3d169bb 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -94,6 +94,10 @@ struct screen_info screen_info = {
>>        .orig_video_points = 16
>>  };
>>
>> +/* Variables required to store legacy IO irq routing */
>> +int of_i8042_kbd_irq;
>> +int of_i8042_aux_irq;
>> +
>>  #ifdef __DO_IRQ_CANON
>>  /* XXX should go elsewhere eventually */
>>  int ppc_do_canonicalize_irqs;
>> @@ -567,6 +571,15 @@ int check_legacy_ioport(unsigned long base_port)
>>                        np = of_find_compatible_node(NULL, NULL, "pnpPNP,f03");
>>                if (np) {
>>                        parent = of_get_parent(np);
>> +
>> +                       of_i8042_kbd_irq = irq_of_parse_and_map(parent, 0);
>> +                       if (!of_i8042_kbd_irq)
>> +                               of_i8042_kbd_irq = 1;
>> +
>> +                       of_i8042_aux_irq = irq_of_parse_and_map(parent, 1);
>> +                       if (!of_i8042_aux_irq)
>> +                               of_i8042_aux_irq = 12;
>> +
>>     
>
> The patch looks okay to me.
>
> BTW, where is the i8042 binding documented?  Ben, is this location of
> the kbd/mouse irq historical,

i8042 is, of course, the legacy PC keyboard interrupt controller, and 
the IRQs that it generates on behalf of its attached keyboard and mouse 
have always been 1 and 12 on the PC platforms that drive the hardware 
designs of junk I/O chips.  By the time that PowerPC came on the market, 
the i8042 functionality was always implemented as a subsystem within a 
much larger "SuperIO" chip, which often included the (legacy PC) 
interrupt controller functionality.  Those SuperIO chips let you move 
the IRQ numbers around for some of the included devices, but I don't 
remember whether or not you could move the IRQs for the keyboard and 
mouse.  Even if you could, "nobody" ever did it, because people were so 
accustomed to 1 and 12 being keyboard and mouse that changing them would 
just cause too much confusion.  There was also the issue of setting the 
edge/level and polarity correctly for the various IRQs.  Moving the 
kbd/mouse IRQs would have a ripple effect on other old-and-dusty code 
that nobody wanted to touch.

The design of PReP (PowerPC Reference Platform) was amusing to watch.  
Apple was wanting to make it into a 68K Macintosh I/O system with a 
PowerPC grafted in, while IBM wanted a conventional PC with a PowerPC 
grafted in.  IBM stacked the committee and basically got what they 
wanted - a PC with a different CPU chip.  At the Comdex show where they 
rolled out the PReP spec, Apple had their own announcement to make - 
Apple wasn't going to use PReP.  So IBM's power play backfired.

The PReP committee (consisting of representatives from IBM, Apple, 
Motorola, and a few other bit players like myself) then went into panic 
mode, and came out with CHRP.  CHRP was PReP with a legacy Macintosh I/O 
system bolted onto the side.  So you had the worst of both worlds.  In 
the PReP mode, you had PC-style I/O like IDE, i8042, 8259 interrupt 
controller, etc.  In the Mac mode, you had SCSI (using a horrible 
ancient programming model that nobody else was using anymore), ADB, and 
an OpenPIC interrupt controller.  The chipsets had to support both sets.

The final shoe dropped 18 months later, when Steve Jobs re-took Apple 
and announced that Apple was not in fact going to license MacOS for use 
on third-party CHRP machines.

The original binding documents for the PC-style I/O system were driven 
from the IBM side.  I may have written some of the text (or maybe not; I 
forget), but it was IBM who stipulated how it was going to work.


>  or is it just something that we happened
> to get when the .dts files were first created?  Having the irq
> specified directly in the kbd or aux nodes would make a lot more
> sense, and if this isn't something already nailed down, then it
> probably does make sense to move the irq specification, fall back to
> the parent node to still support older trees, and with the hard coded
> irq numbers as the last resort.
>
> Cheers,
> g.
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
>
>   
