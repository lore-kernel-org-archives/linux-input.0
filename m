From: Chen Gang <gang.chen.5i5j-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 09:27:58 +0800
Message-ID: <53C7269E.4010702@gmail.com>
References: <201407130545.23004.marex@denx.de> <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com> <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de> <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de> <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de> <20140713192202.GA19090@kroah.com> <53C2DF12.6040507@nod.at> <20140713201753.GA29955@kroah.com> <53C39569.9020802@nod.at> <53C3994C.1010309@metafoo.de> <53C39B66.4060500@nod.at> <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC@gmail.com> <53C47725.8000005@gmail.com> <53C47B76.4080306@roeck-us.net> <53C47FB7.6080304@gmail.com> <53C53CE1.4090803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53C53CE1.4090803-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, teg-B22kvLQNl6c@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Liqin Chen <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Mischa.Jonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-input@vger.kernel.org



On 07/15/2014 10:38 PM, Chen Gang wrote:
> On 07/15/2014 09:11 AM, Chen Gang wrote:
>>
>>
>> On 07/15/2014 08:53 AM, Guenter Roeck wrote:
>>> On 07/14/2014 05:34 PM, Chen Gang wrote:
>>>> On 07/14/2014 05:22 PM, Chen Gang wrote:
>>>>>
>>>>> =E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=
=8D=884:57=EF=BC=8CRichard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org> =E5=86=99=E9=81=93=
=EF=BC=9A
>>>>>
>>>>>> Am 14.07.2014 10:48, schrieb Lars-Peter Clausen:
>>>>>>> On 07/14/2014 10:31 AM, Richard Weinberger wrote:
>>>>>>>> Am 13.07.2014 22:17, schrieb Greg Kroah-Hartman:
>>>>>>>>> On Sun, Jul 13, 2014 at 09:33:38PM +0200, Richard Weinberger =
wrote:
>>>>>>>>>> Maybe we could add COMPILE_TEST to the version string too?
>>>>>>>>>> Just to detect such kernels fast in user bug reports...
>>>>>>>>>
>>>>>>>>> What kind of bug report are you going to get?
>>>>>>>>
>>>>>>>> User manages to enable CONFIG_FOO by selecting COMPILE_TEST an=
d
>>>>>>>> complains that it does not work. :)
>>>>>>>
>>>>>>> These drivers are typically drivers for some SoC peripheral and=
 the
>>>>>>> device will simply physically not exist on a platform that does=
 not
>>>>>>> provide HAS_IOMEM. This is not really any
>>>>>>> different from making the driver selectable via COMPILE_TEST fo=
r
>>>>>>> any other platform. To hit the issue you'd have to instantiate =
a
>>>>>>> device driver instance for a device that
>>>>>>> physically does not exist. This will always result in a failure=
=2E
>>>>>>
>>>>>> Okay, you have convinced me. :)
>>>>>>
>>>>
>>>> After search the history patches, I found one related patch which =
made
>>>> by myself (when I am in Asianux):
>>>>
>>>>    "https://lkml.org/lkml/2013/7/1/641"
>>>>
>>>> For me, it is a long discussion, and forced many members have to j=
oin
>>>> in. Please help check again.
>>>>
>>>
>>> One thing you could try would be to return NULL (or where appropria=
te
>>> an error) in the #else case of CONFIG_HAS_IOMEM and CONFIG_HAS_IOPO=
RT,
>>> ie dont take COMPILE_TEST into account at all. Obviously that means
>>> you won't be able to dump a warning message in the COMPILE_TEST
>>> case, but at least the code would compile. The rejection of above p=
atch
>>> would make a good case for this approach.
>>>

=46or me, only let 'devm_io*map*' support COMPILE_TEST is OK, that can =
fix
all related issues:


[PATCH] lib: devres: Add dumy functions to support COMPILE_TEST when no=
 IOMEM

=46or some architectures which no IOMEM, 'devres' will be skipped. But
many drivers may still want COMPILE_TEST, so let 'devres' support it.

The related error (with allmodconfig under score):

    MODPOST 1365 modules
  ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] undefi=
ned!
  ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko] un=
defined!
  ERROR: "devm_ioremap_resource" [drivers/staging/iio/adc/mxs-lradc.ko]=
 undefined!
  ERROR: "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undefine=
d!
  ERROR: "devm_ioremap_resource" [drivers/input/serio/olpc_apsp.ko] und=
efined!
  ERROR: "devm_ioremap_resource" [drivers/input/serio/arc_ps2.ko] undef=
ined!
  ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-xgene.ko] undefined!
  ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-stk17ta8.ko] undefine=
d!
  ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-ds1742.ko] undefined!
  ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-ds1553.ko] undefined!
  ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-ds1511.ko] undefined!
  ERROR: "devm_ioremap_resource" [drivers/rtc/rtc-ds1286.ko] undefined!
  ERROR: "devm_ioremap" [drivers/rtc/rtc-rp5c01.ko] undefined!
  ERROR: "devm_ioremap" [drivers/rtc/rtc-msm6242.ko] undefined!
  ERROR: "devm_ioremap" [drivers/rtc/rtc-m48t59.ko] undefined!
  ERROR: "devm_ioremap" [drivers/rtc/rtc-m48t35.ko] undefined!
  ERROR: "devm_ioremap" [drivers/rtc/rtc-bq4802.ko] undefined!


Signed-off-by: Chen Gang <gang.chen.5i5j-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/device.h |  9 +++++++++
 include/linux/io.h     | 30 +++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index c2421e0..a7500c3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -630,7 +630,16 @@ extern unsigned long devm_get_free_pages(struct de=
vice *dev,
 					 gfp_t gfp_mask, unsigned int order);
 extern void devm_free_pages(struct device *dev, unsigned long addr);
=20
+#ifdef CONFIG_HAS_IOMEM
 void __iomem *devm_ioremap_resource(struct device *dev, struct resourc=
e *res);
+#elif defined(CONFIG_COMPILE_TEST)
+static inline void __iomem *devm_ioremap_resource(struct device *dev,
+						struct resource *res)
+{
+	pr_warn("no hardware io memory, only for COMPILE_TEST\n");
+	return (__force void __iomem *)ERR_PTR(-ENXIO);
+}
+#endif /* CONFIG_HAS_IOMEM || CONFIG_COMPILE_TEST */
=20
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *=
data);
diff --git a/include/linux/io.h b/include/linux/io.h
index b76e6e5..59128aa 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -58,14 +58,42 @@ static inline void devm_ioport_unmap(struct device =
*dev, void __iomem *addr)
 }
 #endif
=20
+#ifdef CONFIG_HAS_IOMEM
+
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			    unsigned long size);
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t=
 offset,
 				    unsigned long size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
+void devm_ioremap_release(struct device *dev, void *res);
+
+#elif defined(CONFIG_COMPILE_TEST)
+
+static inline void __iomem *devm_ioremap(struct device *dev,
+				resource_size_t offset, unsigned long size)
+{
+	pr_warn("no hardware io memory, only for COMPILE_TEST\n");
+	return NULL;
+}
+static inline void __iomem *devm_ioremap_nocache(struct device *dev,
+				resource_size_t offset, unsigned long size)
+{
+	pr_warn("no hardware io memory, only for COMPILE_TEST\n");
+	return NULL;
+}
+
+static inline void devm_iounmap(struct device *dev, void __iomem *addr=
)
+{
+}
+
+static inline void devm_ioremap_release(struct device *dev, void *res)
+{
+}
+
+#endif /* CONFIG_HAS_IOMEM || CONFIG_COMPILE_TEST */
+
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
-void devm_ioremap_release(struct device *dev, void *res);
=20
 /*
  * Some systems do not have legacy ISA devices.
--=20
1.9.2.459.g68773ac

>>
>> OK, thanks: at least, it can be improved.  But still welcome any oth=
er
>> opinions of another related members.
>>
>=20
> If no reply within 3 days (2014-07-18), I shall try to send related
> patch for it within this week end (2014-07-20).
>=20
> Thanks.
>=20

--=20
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
