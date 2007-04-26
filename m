From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Cobalt button interface driver support
Date: Thu, 26 Apr 2007 08:29:25 -0400
Message-ID: <d120d5000704260529x1f41a5dkc43dbffc34ba6ff0@mail.gmail.com>
References: <20070216123608.733f04a3.yoichi_yuasa@tripeaks.co.jp>
	 <200704040001.41494.dtor@insightbb.com>
	 <200704050502.l3552gss048910@mbox31.po.2iij.net>
	 <200704250134.33610.dtor@insightbb.com>
	 <200704260640.l3Q6eP6R020764@mbox32.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200704260640.l3Q6eP6R020764@mbox32.po.2iij.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 4/26/07, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> Dmitry Torokhov <dtor@insightbb.com> wrote:
> >
> > Coudl you please try couple more patches, please? I wrote a generic
> > stub for polled (as opposed to interrupt-driven) input devices and
> > converting existing drivers to use it. Cobalt buttons seem to be
> > a good candidate...
>
> Looks good to me and works fine.
>
> Acked-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
>

Thank you for testing/review.

-- 
Dmitry
