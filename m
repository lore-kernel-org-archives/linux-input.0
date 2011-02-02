From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] altera_ps2: Add devicetree support
Date: Tue, 1 Feb 2011 20:45:04 -0800
Message-ID: <20110202044503.GA19533@core.coreip.homeip.net>
References: <20110117220415.GB17963@angua.secretlab.ca>
	<1295848693-28472-1-git-send-email-thomas@wytron.com.tw>
	<20110202043121.GF29148@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110202043121.GF29148-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
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
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 01, 2011 at 09:31:21PM -0700, Grant Likely wrote:
> On Mon, Jan 24, 2011 at 01:58:13PM +0800, Thomas Chou wrote:
> > @@ -182,6 +189,7 @@ static struct platform_driver altera_ps2_driver = {
> >  	.driver	= {
> >  		.name	= DRV_NAME,
> >  		.owner	= THIS_MODULE,
> > +		.of_match_table = altera_ps2_match,
> 
> At the moment, this patch can only be applied against my
> devicetree/next branch since there is a #ifdef CONFIG_OF around
> of_match_table in mainline, and the patch to remove it is in my next
> branch.  I'm okay with taking it through my tree if Dmitry agrees.
> 

Actually I was going to ask you if you could do just that.

Thanks.

-- 
Dmitry
