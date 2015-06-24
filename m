From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] touchscreen: sun4i-ts: Really fix A10
 temperature reporting
Date: Wed, 24 Jun 2015 09:16:54 +0200
Message-ID: <558A5966.9010908@redhat.com>
References: <1425893870-28715-1-git-send-email-hdegoede@redhat.com> <41a7a857-96fd-48ab-9778-127cfc091ef0@googlegroups.com> <5589B78C.4080600@redhat.com> <20150623195424.GE40168@dtor-ws>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORB25SVGWAKGQEQP5CDFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150623195424.GE40168@dtor-ws>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 23-06-15 21:54, Dmitry Torokhov wrote:
> On Tue, Jun 23, 2015 at 09:46:20PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 06/23/2015 05:06 PM, m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>>> Hi Hans,
>>>
>>> is it possible that this patch (and the parent commit "Input: sun4i-ts =
- allow controlling filter and sensitivity via DT") has quite an adversial =
effect on other boards than the ones tested?
>>>
>>> On my Lemaker Bananapi the temperature is now being reported as somwher=
e between -15=C2=B0C to -10=C2=B0C with the latest Kernel 4.1.0. These nega=
tive values are obviously way off. On Kernel 4.0.5 the temperature reading =
was usually around 40=C2=B0C. While that might not have been accurate eithe=
r, it was at least plausible.
>>
>> The temperature curve for the A20 SoC was not changed, if it did change =
then
>> you're using an old dtb file with a new kernel, you must always update y=
our
>> dtb file together with the kernel.
>
> Umm, we should keep compatibility with old DTS...

Right, unfortunately that is not always possible, and with sunxi boards the=
 dtb
is always shipped together with the kernel, and the dtb as ABI rule really =
is
intended for the case where the dtb ships with the board/firmware.

That does not mean that we can go and break it every other day, but the pro=
blem
in this case is that we shipped a dts for all boards with a compatible of
allwinner,sun4i-a10-ts, and then later on we found out that the temperature
curve for the build in temp sensor is different for the A10 compared to the
A13/A20, so we adjusted the kernel driver to have 2 temperature curves,
1 for the A10 and one for the later models, and adjusted the compatible in
the dts for later models to allwinner,sun5i-a13-ts, note that the actual
touchscreen functionality is unchanged and works fine with both compatibles=
,
the only thing which is happening now is that Timo is seeing a different
temperature because he is using the new A10 temperature curve on his A20,
other then that everything still works 100%, and there really was
no other way to deal with this.

Let me also reply to one of Timo's later mails here, as that explains
the real problem:

On 23-06-15 23:06, m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:> Hi again,
 >
 > Am Dienstag, 23. Juni 2015 21:46:25 UTC+2 schrieb Hans de Goede:
<snip>
 >>> On my Lemaker Bananapi the temperature is now being reported as somwhe=
re between -15=C2=B0C to -10=C2=B0C with the latest Kernel 4.1.0. These neg=
ative values are obviously way off. On Kernel 4.0.5 the temperature reading=
 was usually around 40=C2=B0C. While that might not have been accurate eith=
er, it was at least plausible.
 >>
 >> The temperature curve for the A20 SoC was not changed, if it did change=
 then
 >> you're using an old dtb file with a new kernel, you must always update =
your
 >> dtb file together with the kernel.
 >
 > I just checked the diff for Linux 4.0 and 4.1 and noticed that sun7i-a20=
.dtsi in fact has not changed. Is it possible that something that should ha=
ve been merged got delayed?
 >
 > I looked in Maxime's tree "dt-for-4.2" and found this patch that looks l=
ike it could be related: https://git.kernel.org/cgit/linux/kernel/git/mripa=
rd/linux.git/commit/?h=3Dsunxi/dt-for-4.2&id=3D8bf1b9b3d90194a174493febc731=
f7783f2adf1a

Ah yes, something went wrong during the 4.1 cycle wrt merging ARM patches
which have caused almost all ARM patches intended for 4.1 to get delayed to
4.2, including that one, that is the problem.

We did our best to update the driver and the dts in lockstep, and you shoul=
d
have never seen this problem, but the missing of the merge window for all
ARM patches during the 4.1 cycle has caused our carefully planned lock-step
update to fail, sorry about that.

Maxime I think we should send the mentioned dts patch to stable for 4.1 ,
do you agree ?

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
