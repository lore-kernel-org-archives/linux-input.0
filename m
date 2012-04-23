From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix regression in pci_restore_state()
Date: Mon, 23 Apr 2012 16:33:41 -0600
Message-ID: <CAErSpo4MRASkhaeTKozFuBRH13koV6=evC5GVAyJ0K222B6=aw@mail.gmail.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com>
 <201204152140.40747.rjw@sisk.pl> <CAErSpo4St6zBBz7131Ne3BEHNO8Xcq8sCy3T5HV1F0B1B1u1cg@mail.gmail.com>
 <201204232153.57351.rjw@sisk.pl> <4F95B67D.7020706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59964 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab2DWWeD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 18:34:03 -0400
Received: by lbbgf7 with SMTP id gf7so42745lbb.19
        for <linux-input@vger.kernel.org>; Mon, 23 Apr 2012 15:34:02 -0700 (PDT)
In-Reply-To: <4F95B67D.7020706@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Don Dutile <ddutile@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Mikko Vinni <mmvinni@yahoo.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On Mon, Apr 23, 2012 at 2:07 PM, Don Dutile <ddutile@redhat.com> wrote:
> On 04/23/2012 03:53 PM, Rafael J. Wysocki wrote:
>>
>> On Monday, April 23, 2012, Bjorn Helgaas wrote:
>>>
>>> On Sun, Apr 15, 2012 at 1:40 PM, Rafael J. Wysocki<rjw@sisk.pl> =A0=
wrote:
>>>>
>>>> On Sunday, April 15, 2012, Linus Torvalds wrote:
>>>>>
>>>>> On Sun, Apr 15, 2012 at 11:47 AM, Rafael J. Wysocki<rjw@sisk.pl>
>>>>> =A0wrote:
>>>>>>
>>>>>>
>>>>>> mdelay(10) doesn't really look good either to me in this case, t=
hough.
>>>>>
>>>>>
>>>>> Oh, I agree. What kind of ass-backwards device actually needs tha=
t
>>>>> kind of crazy delays? It is almost certainly buggy.
>>>>>
>>>>> With retries, 10ms delays are totally unacceptable. There's somet=
hing
>>>>> wrong.
>>>>>
>>>>> A single ms *may* be ok.
>>>>>
>>>>> Anyway, can you also split the actual "write _one_ register with
>>>>> retry" into a function of its own? The code looks like crap with =
those
>>>>> multiple levels of looping, with conditionals inside them etc. Wi=
th a
>>>>> simple helper function, you could change the break into return, a=
nd it
>>>>> would look much better, I bet.
>>>>
>>>>
>>>> Sure. =A0It appears cleaner this way.
>>>>
>>>> ---
>>>> From: Rafael J. Wysocki<rjw@sisk.pl>
>>>> Subject: PCI: Fix regression in pci_restore_state(), v3
>>>>
>>>> Commit 26f41062f28de65e11d3cf353e52d0be73442be1
>>>>
>>>> =A0 =A0PCI: check for pci bar restore completion and retry
>>>>
>>>> attempted to address problems with PCI BAR restoration on systems
>>>> where FLR had not been completed before pci_restore_state() was
>>>> called, but it did that in an utterly wrong way.
>>>>
>>>> First off, instead of retrying the writes for the BAR registers
>>>> only, it did that for all of the PCI config space of the device,
>>>> including the status register (whose value after the write quite
>>>> obviously need not be the same as the written one). =A0Second, it
>>>> added arbitrary delay to pci_restore_state() even for systems
>>>> where the PCI config space restoration was successful at first
>>>> attempt. =A0Finally, the mdelay(10) it added to every iteration of=
 the
>>>> writing loop was way too much of a delay for any reasonable device=
=2E
>>>>
>>>> All of this actually caused resume failures for some devices on
>>>> the Mikko's system.
>>>>
>>>> To fix the regression, make pci_restore_state() only retry the
>>>> writes for BAR registers and only wait if the first read from
>>>> the register doesn't return the written value. =A0Additionaly, mak=
e
>>>> it wait for 1 ms, instead of 10 ms, after every failing attempt
>>>> to write into config space.
>>>>
>>>> Reported-by: Mikko Vinni<mmvinni@yahoo.com>
>>>> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
>>>> ---
>>>> =A0drivers/pci/pci.c | =A0 57
>>>> ++++++++++++++++++++++++++++++++++++------------------
>>>> =A01 file changed, 39 insertions(+), 18 deletions(-)
>>>>
>>>> Index: linux/drivers/pci/pci.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- linux.orig/drivers/pci/pci.c
>>>> +++ linux/drivers/pci/pci.c
>>>> @@ -967,16 +967,47 @@ pci_save_state(struct pci_dev *dev)
>>>> =A0 =A0 =A0 =A0return 0;
>>>> =A0}
>>>>
>>>> +static void pci_restore_config_dword(struct pci_dev *pdev, int of=
fset,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0u32 saved_val, int retry)
>>>> +{
>>>> + =A0 =A0 =A0 u32 val;
>>>> +
>>>> + =A0 =A0 =A0 pci_read_config_dword(pdev, offset,&val);
>>>> + =A0 =A0 =A0 if (val =3D=3D saved_val)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 =A0 =A0 for (;;) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "restoring confi=
g space at offset "
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%#x (was %#x, writi=
ng %#x)\n", offset, val,
>>>> saved_val);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_dword(pdev, offset,=
 saved_val);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retry--<=3D 0)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_dword(pdev, offset,&=
val);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val =3D=3D saved_val)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
>>>> + =A0 =A0 =A0 }
>>>> +}
>>>> +
>>>> +static void pci_restore_config_space(struct pci_dev *pdev, int st=
art,
>>>> int end,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0int retry)
>>>> +{
>>>> + =A0 =A0 =A0 int index;
>>>> +
>>>> + =A0 =A0 =A0 for (index =3D end; index>=3D start; index--)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_restore_config_dword(pdev, 4 * i=
ndex,
>>>> +
>>>> =A0pdev->saved_config_space[index],
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0retry);
>>>> +}
>>>> +
>>>> =A0/**
>>>> =A0* pci_restore_state - Restore the saved state of a PCI device
>>>> =A0* @dev: - PCI device that we're dealing with
>>>> =A0*/
>>>> =A0void pci_restore_state(struct pci_dev *dev)
>>>> =A0{
>>>> - =A0 =A0 =A0 int i;
>>>> - =A0 =A0 =A0 u32 val;
>>>> - =A0 =A0 =A0 int tries;
>>>> -
>>>> =A0 =A0 =A0 =A0if (!dev->state_saved)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>>
>>>> @@ -984,24 +1015,14 @@ void pci_restore_state(struct pci_dev *d
>>>> =A0 =A0 =A0 =A0pci_restore_pcie_state(dev);
>>>> =A0 =A0 =A0 =A0pci_restore_ats_state(dev);
>>>>
>>>> + =A0 =A0 =A0 pci_restore_config_space(dev, 10, 15, 0);
>>>> =A0 =A0 =A0 =A0/*
>>>> =A0 =A0 =A0 =A0 * The Base Address register should be programmed b=
efore the
>>>> command
>>>> =A0 =A0 =A0 =A0 * register(s)
>>>> =A0 =A0 =A0 =A0 */
>>>> - =A0 =A0 =A0 for (i =3D 15; i>=3D 0; i--) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_dword(dev, i * 4,&va=
l);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tries =3D 10;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (tries&& =A0val !=3D dev->save=
d_config_space[i]) {
>>>>
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->dev, "=
restoring config "
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "spa=
ce at offset %#x (was %#x, writing
>>>> %#x)\n",
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, v=
al,
>>>> (int)dev->saved_config_space[i]);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_dwo=
rd(dev,i * 4,
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-=
>saved_config_space[i]);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_dwor=
d(dev, i * 4,&val);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(10);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tries--;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> - =A0 =A0 =A0 }
>>>> + =A0 =A0 =A0 pci_restore_config_space(dev, 4, 9, 10);
>>>> + =A0 =A0 =A0 pci_restore_config_space(dev, 0, 3, 0);
>>>> +
>>>> =A0 =A0 =A0 =A0pci_restore_pcix_state(dev);
>>>> =A0 =A0 =A0 =A0pci_restore_msi_state(dev);
>>>> =A0 =A0 =A0 =A0pci_restore_iov_state(dev);
>>>
>>>
>>> I'd feel better about this if there were a way to delay in the FLR
>>> path instead. =A0If we delay in the restore path, we're only fixing=
 one
>>> of the many ways config space can be written. =A0Other paths that w=
rite
>>> config space will just silently fail.
>>>
>>> The PCIe spec (r3.0, sec 6.6.2) mentions waiting for the "pre-FLR
>>> value for Completion Timeout," but I don't see anything that looks
>>> like that in pcie_flr() or pci_af_flr(). =A0Are there any other dir=
ect
>>> ways we can detect when the FLR is complete?
>>
>>
>> I'm not aware of any.
>>
>> Thanks,
>> Rafael
>
> I don't think so, either.
> I believe an ECN is being worked in the PCI-SIG
> to add such a notification, though.
> Even if adopted, need to wait for another crank of the hw before
> the notification can be used.

I agree, we can't do something that works only on new hardware -- we
have to make the existing hardware in the field work.

What about the "waiting for as much time as the pre-FLR value for
Completion Timeout" part?

Or can we do something like asserting FLR, sleeping 100ms, then
attempting a write to something in config space and retrying until it
sticks?  It's kludgy, but I'm not sure it's any worse than putting the
retries in the restore path, and it would have the advantage that
other writers of config space wouldn't have to worry.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
