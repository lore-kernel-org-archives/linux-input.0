From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 4/4] da850-evm: add baseboard UI expander buttons,
	switches and LEDs
Date: Tue, 23 Nov 2010 18:12:38 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024793124F@dbde02.ent.ti.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
	<d6d59b4a3c34149008f3681e0d6106efa15f354d.1289935504.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EAA89@dbde02.ent.ti.com>
	<AANLkTike4sRvptEe9PXLT2u+SrFMOpNC6pvLPSzBfVOX@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EB2D8@dbde02.ent.ti.com>
	<AANLkTin8+y0xkjv+RmnSZNKXgfwr2iV3c9P7cBMfVw3k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <AANLkTin8+y0xkjv+RmnSZNKXgfwr2iV3c9P7cBMfVw3k-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Cc: "Govindarajan, Sriramakrishnan" <srk-l0cyMroinI0@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Alexander Clouter <alex-L4GPcECwBoDe9xe1eoZjHA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Cordahi <christophercordahi-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Ben,

On Mon, Nov 22, 2010 at 19:45:46, Ben Gardiner wrote:
> Hi Sekhar,
>
> On Mon, Nov 22, 2010 at 7:00 AM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> > Thanks for the explanation. I should have probably asked
> > earlier, why do we need to prevent sysfs access of
> > deep sleep enable and sw reset pins? We don't seem to be
> > using them in the kernel either.
>
> You're welcome.
>
> I was assuming that those pins were not exported as gpio pins on
> purpose; I was taking the prudent approach to prevent haphazard
> toggling of sw_rst and deep_sleep_en from userspace. sw_rst because it
> could initiate a reset of the cpu when toggled and deep_sleep_en
> because it can override the behaviour of davinci_pm_enter().
>
> I'm not sure how they would be used by existing kernel classes either.
> The sw_rst pin could be used for reset but since it is on the other
> end of an i2c bus and there is an existing implementation of reset
> using the on chip watchdog I don't think it would be benficial to
> switch. Deep_sleep_en could override the behaviour in
> davinci_pm_enter() -- _maybe_ (I don't really know) it could be used
> as a hardware-assisted suspend-blocker? But I totally guessing here.

My preference would be to leave these pins as is
(don't call a gpio_request() on them) till someone
comes up with a use case for them. From what you
described, sysfs access cannot happen "accidently"
so someone accessing these pins from sysfs surely
knows what he is doing.

Thanks,
Sekhar
