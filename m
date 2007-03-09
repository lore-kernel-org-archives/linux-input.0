From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Fix locking in mousedev
Date: Fri, 9 Mar 2007 10:36:56 -0800
Message-ID: <20070309103656.cd681677.zaitcev@redhat.com>
References: <20070228110631.86a150e4.zaitcev@redhat.com>
	<d120d5000703090628p46556d52qb94b523fda4e947d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703090628p46556d52qb94b523fda4e947d@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, zaitcev@redhat.com
List-Id: linux-input@vger.kernel.org

On Fri, 9 Mar 2007 09:28:49 -0500, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> On 2/28/07, Pete Zaitcev <zaitcev@redhat.com> wrote:

> > Dmitry, please consider getting rid of the list of handles entirely.
> > The other major user is drivers/char/keyboard.c.
> 
> I agree that handlers should not access h_list nad use their own
> private lists instead. However input core still needs that list to
> maintain its books.

Hmm. So it appears that my patch wastes 2 ulongs per input handle
then, in the name of preventing oopses. OK.

> I agree with the patch, unfortunately in lands squarely in the middle
> of me restructuring the code (swiitch to struct device, proper
> refcounting, etc) but I will try to adopt it.

Don't worry about this too much, I can always retest and resubmit,
as long as the main idea is agreeable to you. My users are on RHEL.
Therefore, my main concern is to get something into your tree in
order to avoid this regressing in the future. Meanwhile, users of
our 2.6.9 and 2.6.18 forks get a version of this patch.

-- Pete
