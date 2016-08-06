From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: touchscreen: Remove duplicate ft6236 driver
Date: Fri, 5 Aug 2016 19:22:43 -0700
Message-ID: <20160806022243.GB20562@dtor-ws>
References: <1470381871-4086-1-git-send-email-hdegoede@redhat.com>
 <1470381871-4086-2-git-send-email-hdegoede@redhat.com>
 <72101a2a-ccf0-b0bc-3859-50a43f990027@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <72101a2a-ccf0-b0bc-3859-50a43f990027@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, linux-input@vger.kernel.org, Sean Cross <xobs@kosagi.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 05, 2016 at 05:07:20PM +0200, Stefan Wahren wrote:
> Hi Hans,
> 
> Am 05.08.2016 um 09:24 schrieb Hans de Goede:
> >The new(ish) ft6236 simply re-implements the M09 protocol of the
> >(much) older edt-ft5x06.c driver.
> >
> >This commit removes this duplicate driver and adds the i2c ids and
> >dt compatible string to the edt-ft5x06.c driver to keep compatibility.
> 
> i think only remove of the driver is incorrect here.
> 
> Since there are two similar but still different DT bindings
> 
> Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> 
> Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt
> 
> the DT handling of edt-ft5x06.c needs to be extended and then
> finally driver and binding could be removed.

I believe Hans made sure edt-ft5x06.c can handle focaltech-ft6236
bindings. Do you see a discrepancy?

Thanks.

-- 
Dmitry
