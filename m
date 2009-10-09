From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] add analog devices
	AD714X	captouchinput driver
Date: Fri, 9 Oct 2009 09:22:20 -0700
Message-ID: <20091009162219.GB1092@core.coreip.homeip.net>
References: <1252652006-5270-1-git-send-email-21cnbao@gmail.com>
	<8A42379416420646B9BFAC9682273B6D0DC3BD95@limkexm3.ad.analog.com>
	<8bd0f97a0910090156g2a8fba58r4085422f3a79c892@mail.gmail.com>
	<1255079007.8362.70.camel@macbook.infradead.org>
	<8bd0f97a0910090218j6a2aa6aaq497fba3f04d7b19f@mail.gmail.com>
	<8bd0f97a0910090311t5f5167c8r336afaa6f790e1a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910090311t5f5167c8r336afaa6f790e1a9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, "Hennerich,
	Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 09, 2009 at 06:11:45AM -0400, Mike Frysinger wrote:
> On Fri, Oct 9, 2009 at 05:18, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > we could have three modules here: ad714x, ad714x-i2c, ad714x-spi
> 
> are you ok with this approach Dmitry ?  this way people can
> load/unload a specific bus without affecting the core or the other
> bus, and errors with loading one bus type wouldnt affect loading of
> the other.

Yes, I think this is the most clean way.

-- 
Dmitry
