From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] input: touchscreen: atmel_mxt_ts: Add Device Tree
 support
Date: Thu, 11 Apr 2013 22:32:55 +0200
Message-ID: <3024802.3b8y84VJNf@flatron>
References: <1365092066-31753-1-git-send-email-t.figa@samsung.com>
 <20130404173040.GB12302@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130404173040.GB12302-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Thursday 04 of April 2013 10:30:40 Dmitry Torokhov wrote:
> Hi Tomasz,
> 
> On Thu, Apr 04, 2013 at 06:14:24PM +0200, Tomasz Figa wrote:
> > This series is an attempt to add Device Tree support to Atmel maXtouch
> > touchscreen driver.
> > 
> > First patch adds support for VDD voltage regulator to get operating
> > voltage using regulator API instead of a driver specific field in
> > platform data.
> > 
> > Second patch implements Device Tree bindings for the driver and adds
> > respective documentation.
> > 
> > Tested on Universal C210 board.
> 
> Please coordinate this effort with Nick Dyer <nick.dyer-8YpZQSjhsQH10XsdtD+oqA@public.gmane.org>,
> Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> and Benson Leung
> <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> as there is a big update to the atmel_mxt_ts in
> works and I would prefer not to disturb it.

OK. Let's hold with my patches until the big update gets merged then.

Best regards,
Tomasz
