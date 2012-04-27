From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix regression in pci_restore_state()
Date: Fri, 27 Apr 2012 16:20:23 -0600
Message-ID: <CAErSpo6PQLS0_KO1YxmZZSkLrBpZKd0Jzfj3n9UAK_XHbJEsTA@mail.gmail.com>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com>
 <201204152140.40747.rjw@sisk.pl> <CAErSpo4St6zBBz7131Ne3BEHNO8Xcq8sCy3T5HV1F0B1B1u1cg@mail.gmail.com>
 <201204232153.57351.rjw@sisk.pl> <4F95B67D.7020706@redhat.com>
 <CAErSpo4MRASkhaeTKozFuBRH13koV6=evC5GVAyJ0K222B6=aw@mail.gmail.com>
 <4F96CEDB.3060300@redhat.com> <CAErSpo76egMNuVdE7er_DEXG5+Zpo-vAff8+TEQAzpuDhOmSaQ@mail.gmail.com>
 <4F96E44F.9060808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4F96E44F.9060808@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Don Dutile <ddutile@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@linux-foundation.org>, Mikko Vinni <mmvinni@yahoo.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Allen Kay <allen.m.kay@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 24, 2012 at 11:35 AM, Don Dutile <ddutile@redhat.com> wrote=
:
> On 04/24/2012 01:01 PM, Bjorn Helgaas wrote:
>>
>> On Tue, Apr 24, 2012 at 10:03 AM, Don Dutile<ddutile@redhat.com> =A0=
wrote:
>>>
>>> On 04/23/2012 06:33 PM, Bjorn Helgaas wrote:
>>>>
>>>>
>>>> On Mon, Apr 23, 2012 at 2:07 PM, Don Dutile<ddutile@redhat.com>
>>>> =A0wrote:
>>>>>
>>>>>
>>>>> On 04/23/2012 03:53 PM, Rafael J. Wysocki wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Monday, April 23, 2012, Bjorn Helgaas wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Sun, Apr 15, 2012 at 1:40 PM, Rafael J. Wysocki<rjw@sisk.pl>
>>>>>>> =A0wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On Sunday, April 15, 2012, Linus Torvalds wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Sun, Apr 15, 2012 at 11:47 AM, Rafael J. Wysocki<rjw@sisk.=
pl>
>>>>>>>>> =A0wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> mdelay(10) doesn't really look good either to me in this cas=
e,
>>>>>>>>>> though.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Oh, I agree. What kind of ass-backwards device actually needs=
 that
>>>>>>>>> kind of crazy delays? It is almost certainly buggy.
>>>>>>>>>
>>>>>>>>> With retries, 10ms delays are totally unacceptable. There's
>>>>>>>>> something
>>>>>>>>> wrong.
>>>>>>>>>
>>>>>>>>> A single ms *may* be ok.
>>>>>>>>>
>>>>>>>>> Anyway, can you also split the actual "write _one_ register w=
ith
>>>>>>>>> retry" into a function of its own? The code looks like crap w=
ith
>>>>>>>>> those
>>>>>>>>> multiple levels of looping, with conditionals inside them etc=
=2E With
>>>>>>>>> a
>>>>>>>>> simple helper function, you could change the break into retur=
n, and
>>>>>>>>> it
>>>>>>>>> would look much better, I bet.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Sure. =A0It appears cleaner this way.
>>>>>>>>
>>>>>>>> ---
>>>>>>>> From: Rafael J. Wysocki<rjw@sisk.pl>
>>>>>>>> Subject: PCI: Fix regression in pci_restore_state(), v3
>>>>>>>>
>>>>>>>> Commit 26f41062f28de65e11d3cf353e52d0be73442be1
>>>>>>>>
>>>>>>>> =A0 =A0PCI: check for pci bar restore completion and retry
>>>>>>>>
>>>>>>>> attempted to address problems with PCI BAR restoration on syst=
ems
>>>>>>>> where FLR had not been completed before pci_restore_state() wa=
s
>>>>>>>> called, but it did that in an utterly wrong way.
>>>>>>>>
>>>>>>>> First off, instead of retrying the writes for the BAR register=
s
>>>>>>>> only, it did that for all of the PCI config space of the devic=
e,
>>>>>>>> including the status register (whose value after the write qui=
te
>>>>>>>> obviously need not be the same as the written one). =A0Second,=
 it
>>>>>>>> added arbitrary delay to pci_restore_state() even for systems
>>>>>>>> where the PCI config space restoration was successful at first
>>>>>>>> attempt. =A0Finally, the mdelay(10) it added to every iteratio=
n of the
>>>>>>>> writing loop was way too much of a delay for any reasonable de=
vice.
>>>>>>>>
>>>>>>>> All of this actually caused resume failures for some devices o=
n
>>>>>>>> the Mikko's system.
>>>>>>>>
>>>>>>>> To fix the regression, make pci_restore_state() only retry the
>>>>>>>> writes for BAR registers and only wait if the first read from
>>>>>>>> the register doesn't return the written value. =A0Additionaly,=
 make
>>>>>>>> it wait for 1 ms, instead of 10 ms, after every failing attemp=
t
>>>>>>>> to write into config space.
>>>>>>>>
>>>>>>>> Reported-by: Mikko Vinni<mmvinni@yahoo.com>
>>>>>>>> Signed-off-by: Rafael J. Wysocki<rjw@sisk.pl>
>>>>>>>> ---
>>>>>>>> =A0drivers/pci/pci.c | =A0 57
>>>>>>>> ++++++++++++++++++++++++++++++++++++------------------
>>>>>>>> =A01 file changed, 39 insertions(+), 18 deletions(-)
>>>>>>>>
>>>>>>>> Index: linux/drivers/pci/pci.c
>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>>> --- linux.orig/drivers/pci/pci.c
>>>>>>>> +++ linux/drivers/pci/pci.c
>>>>>>>> @@ -967,16 +967,47 @@ pci_save_state(struct pci_dev *dev)
>>>>>>>> =A0 =A0 =A0 =A0return 0;
>>>>>>>> =A0}
>>>>>>>>
>>>>>>>> +static void pci_restore_config_dword(struct pci_dev *pdev, in=
t
>>>>>>>> offset,
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0u32 saved_val, int retry)
>>>>>>>> +{
>>>>>>>> + =A0 =A0 =A0 u32 val;
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 pci_read_config_dword(pdev, offset,&val);
>>>>>>>> + =A0 =A0 =A0 if (val =3D=3D saved_val)
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 for (;;) {
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "restoring c=
onfig space at
>>>>>>>> offset
>>>>>>>> "
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%#x (was %#x, w=
riting %#x)\n", offset, val,
>>>>>>>> saved_val);
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_dword(pdev, off=
set, saved_val);
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retry--<=3D 0)
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_dword(pdev, offs=
et,&val);
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val =3D=3D saved_val)
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
>>>>>>>> + =A0 =A0 =A0 }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void pci_restore_config_space(struct pci_dev *pdev, in=
t
>>>>>>>> start,
>>>>>>>> int end,
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0int retry)
>>>>>>>> +{
>>>>>>>> + =A0 =A0 =A0 int index;
>>>>>>>> +
>>>>>>>> + =A0 =A0 =A0 for (index =3D end; index>=3D start; index--)
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_restore_config_dword(pdev, 4=
 * index,
>>>>>>>> +
>>>>>>>> =A0pdev->saved_config_space[index],
>>>>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0retry);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> =A0/**
>>>>>>>> =A0* pci_restore_state - Restore the saved state of a PCI devi=
ce
>>>>>>>> =A0* @dev: - PCI device that we're dealing with
>>>>>>>> =A0*/
>>>>>>>> =A0void pci_restore_state(struct pci_dev *dev)
>>>>>>>> =A0{
>>>>>>>> - =A0 =A0 =A0 int i;
>>>>>>>> - =A0 =A0 =A0 u32 val;
>>>>>>>> - =A0 =A0 =A0 int tries;
>>>>>>>> -
>>>>>>>> =A0 =A0 =A0 =A0if (!dev->state_saved)
>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>>>>>>>
>>>>>>>> @@ -984,24 +1015,14 @@ void pci_restore_state(struct pci_dev *=
d
>>>>>>>> =A0 =A0 =A0 =A0pci_restore_pcie_state(dev);
>>>>>>>> =A0 =A0 =A0 =A0pci_restore_ats_state(dev);
>>>>>>>>
>>>>>>>> + =A0 =A0 =A0 pci_restore_config_space(dev, 10, 15, 0);
>>>>>>>> =A0 =A0 =A0 =A0/*
>>>>>>>> =A0 =A0 =A0 =A0 * The Base Address register should be programm=
ed before the
>>>>>>>> command
>>>>>>>> =A0 =A0 =A0 =A0 * register(s)
>>>>>>>> =A0 =A0 =A0 =A0 */
>>>>>>>> - =A0 =A0 =A0 for (i =3D 15; i>=3D 0; i--) {
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_dword(dev, i * 4=
,&val);
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tries =3D 10;
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (tries&& =A0 =A0 =A0val !=3D
>>>>>>>> dev->saved_config_space[i]) {
>>>>>>>>
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&dev->de=
v, "restoring config "
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
"space at offset %#x (was %#x,
>>>>>>>> writing
>>>>>>>> %#x)\n",
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
i, val,
>>>>>>>> (int)dev->saved_config_space[i]);
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config=
_dword(dev,i * 4,
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
dev->saved_config_space[i]);
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_read_config_=
dword(dev, i * 4,&val);
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(10);
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tries--;
>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>>>>> - =A0 =A0 =A0 }
>>>>>>>> + =A0 =A0 =A0 pci_restore_config_space(dev, 4, 9, 10);
>>>>>>>> + =A0 =A0 =A0 pci_restore_config_space(dev, 0, 3, 0);
>>>>>>>> +
>>>>>>>> =A0 =A0 =A0 =A0pci_restore_pcix_state(dev);
>>>>>>>> =A0 =A0 =A0 =A0pci_restore_msi_state(dev);
>>>>>>>> =A0 =A0 =A0 =A0pci_restore_iov_state(dev);
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I'd feel better about this if there were a way to delay in the =
=46LR
>>>>>>> path instead. =A0If we delay in the restore path, we're only fi=
xing one
>>>>>>> of the many ways config space can be written. =A0Other paths th=
at write
>>>>>>> config space will just silently fail.
>>>>>>>
>>>>>>> The PCIe spec (r3.0, sec 6.6.2) mentions waiting for the "pre-F=
LR
>>>>>>> value for Completion Timeout," but I don't see anything that lo=
oks
>>>>>>> like that in pcie_flr() or pci_af_flr(). =A0Are there any other=
 direct
>>>>>>> ways we can detect when the FLR is complete?
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> I'm not aware of any.
>>>>>>
>>>>>> Thanks,
>>>>>> Rafael
>>>>>
>>>>>
>>>>>
>>>>> I don't think so, either.
>>>>> I believe an ECN is being worked in the PCI-SIG
>>>>> to add such a notification, though.
>>>>> Even if adopted, need to wait for another crank of the hw before
>>>>> the notification can be used.
>>>>
>>>>
>>>>
>>>> I agree, we can't do something that works only on new hardware -- =
we
>>>> have to make the existing hardware in the field work.
>>>>
>>>> What about the "waiting for as much time as the pre-FLR value for
>>>> Completion Timeout" part?
>>>>
>>>> Or can we do something like asserting FLR, sleeping 100ms, then
>>>> attempting a write to something in config space and retrying until=
 it
>>>> sticks? =A0It's kludgy, but I'm not sure it's any worse than putti=
ng the
>>>> retries in the restore path, and it would have the advantage that
>>>> other writers of config space wouldn't have to worry.
>>>
>>>
>>> Depending on system config, reading a port that is being FLR'd
>>> can cause AERs, which if a driver is registered for the endpoint,
>>> it will get AERs reported to the driver and potentially complicate =
the
>>> FLRhandling.
>>>
>>> This implies a hook to temp-disable AER during FLR, then turning it
>>> back on (hw&/or sw).
>>
>> Don't we have the same possibility of causing AERs if we add this
>> retry stuff in pci_restore_state()? =A0It sounds like the same
>> possibility exists regardless of whether the config access happens i=
n
>> the FLR path or the restore path.
>
> Dont know; have to re-read thread on where/when pci_restore_state() i=
s
> recalled
> wrt link synch/enable state(s).

I don't know what to do with this patch yet.  Here's what I think
happens with this patch applied, in a case where we have to do some
retries:

    pcie_flr
      pci_write_config_word(dev, PCI_EXP_DEVCTL)  /* start FLR */
      msleep(100)
    ...
    pci_restore_state
      pci_read_config_dword(dev, 0x28)  /* CardBus CIS pointer */
      pci_write_config_dword(dev, 0x28)
      pci_read_config_dword(dev, 0x30)  /* Subsystem ID/vendor ID */
      pci_write_config_dword(dev, 0x30)
      ...
      pci_read_config_dword(dev, 0x10)  /* BAR 0 */
      for (;;) {
        pci_write_config_dword(dev, 0x10, saved_val)
        pci_read_config_dword(dev, 0x10, &val)
        if (val =3D=3D saved_val)
          break;
      }

1) What happens if another code path reads or writes config space
before pci_restore_path()?  As far as I can tell, it fails silently.

2) Apparently (per Don), config access to a device in the middle of
=46LR can cause AER.  If that's true, it seems like even this patch
could cause an AER, and the only possible thing is to rely on a delay
in pcie_flr() or temporarily disable AER.

3) If a config space write being accepted is a signal that the FLR is
complete, why don't we first restore a register where we *check*
whether the write is accepted?  The patch restores dwords 10-15 first,
and we don't retry those, so it seems like those updates could be
lost.  In fact, we do lots of other config writes in
pci_restore_pcie_state(), etc., and presumably all those could be
being dropped.

4) Why doesn't pcie_flr() do anything with the Completion Timeout
(PCIe spec r3.0, sec 6.6.2)?  It seems like using this could cause us
to wait longer than the current 100ms in pcie_flr().

5) If we're not retrying, it seems pointless to even read the register
first.  A nit, I know.

I don't feel comfortable that we understand the real problem here, so
I'm reluctant to apply the patch.  Obviously I know little about FLR
and the restore path, so possibly I just need to be educated :)

Bjorn
