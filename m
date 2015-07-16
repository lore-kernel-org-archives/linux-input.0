From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] input: ambakmi: Fix system PM by converting to modern
 callbacks
Date: Thu, 16 Jul 2015 10:48:06 +0200
Message-ID: <CAPDyKFqu-BJLyP0aDDmZHjAUub=AZyA0YtTRhkZi=roHMaHcXA@mail.gmail.com>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
 <20150522164909.GA40101@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150522164909.GA40101@dtor-ws>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 22 May 2015 at 18:49, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Fri, May 22, 2015 at 04:37:12PM +0200, Ulf Hansson wrote:
>> On 14 April 2015 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> > The legacy system PM support has long time ago been dropped from the
>> > AMBA bus. Align to that by converting to the modern system PM
>> > callbacks.
>> >
>> > Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> What happened with this one? Can we queue it for 4.2?
>
> I was hoping that Russel could give it a spin since he has the
> relevant hardware.
>

Hmm, as there are still no progress could we give it a try and queue
it to get some test in linux-next? I think the patch is trivial and it
would be nice to get it queued as a fix.

Kind regards
Uffe
