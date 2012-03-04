From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] Input: usbtouchscreen: add support for Data Modul
 EasyTouch TP 72037
Date: Sun, 4 Mar 2012 10:42:23 -0800
Message-ID: <20120304184223.GG27647@core.coreip.homeip.net>
References: <ef63b19a6f667b4ffc22f0bacfda60d9e53fcba1.1330505561.git.viresh.kumar@st.com>
 <4F4E828F.2060105@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F4E828F.2060105@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Viresh Kumar <viresh.kumar@st.com>, linux-input@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com, salvatore.dedominicis@st.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 29, 2012 at 08:54:55PM +0100, Daniel Ritz wrote:
> On 2012-02-29 11:07 , Viresh Kumar wrote:
> > From: Armando Visconti <armando.visconti@st.com>
> > 
> > The Data Modul TP 72037 EasyTouch controller is derived from EGALAX
> > controller and is capable of detecting dual contacts. Packets can be 5
> > bytes or 10 bytes long, depending whether one or two contacts are
> > detected. Format is same as EGALAX touch controller, but with x and y
> > coordinates inverted.
> > 
> > Signed-off-by: Armando Visconti <armando.visconti@st.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

...

> 
> Looks good, thanks.
> 
> Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
> 

Applied, thanks everyone.

-- 
Dmitry
