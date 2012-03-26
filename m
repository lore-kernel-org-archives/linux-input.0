From: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] Input: spear-keyboard: add device tree bindings
Date: Mon, 26 Mar 2012 21:05:22 +0530
Message-ID: <CAOh2x=mWOYKZGe_CoGP1SPtUFMKyz4SfaZ_-=4pXWMhKo-9JbQ@mail.gmail.com>
References: <2d5fee8dbe4d188cad43b5e60e9bc8df682781a0.1332754641.git.viresh.kumar@st.com>
 <a2d16bc563cf5c7e8eebf817de0a1eb08d7b96ba.1332754641.git.viresh.kumar@st.com>
 <4F708B8F.10602@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2229099365571077251=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4F708B8F.10602-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--===============2229099365571077251==
Content-Type: multipart/alternative; boundary=f46d04182570581d4e04bc271f38

--f46d04182570581d4e04bc271f38
Content-Type: text/plain; charset=ISO-8859-1

On Mar 26, 2012 9:00 PM, "Stephen Warren" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>
> > +- compatible: "st,spear-kbd"
>
> Should "spear" include some version number so that there's a clear path
> if/when future SoCs need a different binding?

Ya. I will name it spear300-kbd.

> > +- mode: keyboard mode: 0 - 9x9, 1 - 6x6, 2 - 2x2
>
> mode at least should be "st,mode". autorepeat is probably generic enough
> that it doesn't need the vendor prefix.

Ok.

--
Viresh

--f46d04182570581d4e04bc271f38
Content-Type: text/html; charset=ISO-8859-1

<p><br>
On Mar 26, 2012 9:00 PM, &quot;Stephen Warren&quot; &lt;<a href="mailto:swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org">swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; +- compatible: &quot;st,spear-kbd&quot;<br>
&gt;<br>
&gt; Should &quot;spear&quot; include some version number so that there&#39;s a clear path<br>
&gt; if/when future SoCs need a different binding?</p>
<p>Ya. I will name it spear300-kbd.</p>
<p>&gt; &gt; +- mode: keyboard mode: 0 - 9x9, 1 - 6x6, 2 - 2x2<br>
&gt;<br>
&gt; mode at least should be &quot;st,mode&quot;. autorepeat is probably generic enough<br>
&gt; that it doesn&#39;t need the vendor prefix.</p>
<p>Ok.</p>
<p>--<br>
Viresh</p>

--f46d04182570581d4e04bc271f38--

--===============2229099365571077251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2229099365571077251==--
