From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v3] input: touchscreen: Remove duplicate ft6236 driver
Date: Sat, 6 Aug 2016 15:15:17 +0200 (CEST)
Message-ID: <2036456363.114390.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
References: <1470381871-4086-1-git-send-email-hdegoede@redhat.com>
 <1470381871-4086-2-git-send-email-hdegoede@redhat.com>
 <72101a2a-ccf0-b0bc-3859-50a43f990027@i2se.com>
 <20160806022243.GB20562@dtor-ws>
 <424ae37d-6ca9-a950-551a-7643cee726d0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <424ae37d-6ca9-a950-551a-7643cee726d0@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, Sean Cross <xobs@kosagi.com>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

> Hans de Goede <hdegoede@redhat.com> hat am 6. August 2016 um 12:00
> geschrieben:
> 
> 
> Hi,
> 
> On 06-08-16 04:22, Dmitry Torokhov wrote:
> > On Fri, Aug 05, 2016 at 05:07:20PM +0200, Stefan Wahren wrote:
> >> Hi Hans,
> >>
> >> Am 05.08.2016 um 09:24 schrieb Hans de Goede:
> >>> The new(ish) ft6236 simply re-implements the M09 protocol of the
> >>> (much) older edt-ft5x06.c driver.
> >>>
> >>> This commit removes this duplicate driver and adds the i2c ids and
> >>> dt compatible string to the edt-ft5x06.c driver to keep compatibility.
> >>
> >> i think only remove of the driver is incorrect here.
> >>
> >> Since there are two similar but still different DT bindings
> >>
> >> Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> >>
> >> Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt
> >>
> >> the DT handling of edt-ft5x06.c needs to be extended and then
> >> finally driver and binding could be removed.
> >
> > I believe Hans made sure edt-ft5x06.c can handle focaltech-ft6236
> > bindings. Do you see a discrepancy?
> 
> Correct I've double checked that both the i2c protocol and the
> reset gpio binding are compatible. Devices using the focaltech-ft6236.txt
> binding should work fine with the edt-ft5x06.c driver.

i missed the point about touchscreen_parse_properties() and it's properties.
Sorry for the noise. Everything okay.

> 
> Now if someone can test and confirm that on actual hardware that would be
> great...
> 
> And we probably want to remove
> Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt
> and instead add the compatible string that defines to
> Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> 

That would be great.

Stefan

> I can whip up a patch for that, but as said some testing on actual
> hw would be good, preferably before I write said patch.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> p.s.
> 
> (the v3 in the subject is bogus my bad)
