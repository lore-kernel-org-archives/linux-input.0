From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: dts: sun7i: Add keypad node to
 Allwinner A20 SoC
Date: Thu, 17 Sep 2015 13:29:05 +0200
Message-ID: <20150917112905.GC4684@lukather>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
 <1442325957-10102-3-git-send-email-yassinjaffer@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fzZfjcV6kaBgkq89"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBAWI5KXQKGQEUBTVZYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442325957-10102-3-git-send-email-yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--fzZfjcV6kaBgkq89
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Yassin,

On Wed, Sep 16, 2015 at 12:05:55AM +1000, yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add Keypad controller node definition to the A20 SoC.
> 
> Signed-off-by: Yassin Jaffer <yassinjaffer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 333604a..35cc8d0 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1198,6 +1198,15 @@
>  			status = "disabled";
>  		};
>  
> +		kp: kp@01c23000 {

The node name should reflect the class of the device. keypad@01c23000
would be better for example.

It looks good otherwise.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--fzZfjcV6kaBgkq89--
