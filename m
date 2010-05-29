From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v3] powerpc: Add i8042 keyboard and mouse irq parsing
Date: Sat, 29 May 2010 13:35:53 +1000
Message-ID: <1275104153.1931.522.camel@pasglop>
References: <20100525080834.29149.70967.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<AANLkTikve-ZghgpVl3cyjjgWAch-oCJ0EiYK2127f5gS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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


> The patch looks okay to me.
> 
> BTW, where is the i8042 binding documented?  Ben, is this location of
> the kbd/mouse irq historical, or is it just something that we happened
> to get when the .dts files were first created?  Having the irq
> specified directly in the kbd or aux nodes would make a lot more
> sense, and if this isn't something already nailed down, then it
> probably does make sense to move the irq specification, fall back to
> the parent node to still support older trees, and with the hard coded
> irq numbers as the last resort.

That's just ISA crap. It should be in the existing OF bindings.

Cheers,
Ben.
