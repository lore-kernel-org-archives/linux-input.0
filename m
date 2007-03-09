From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Fix locking in mousedev
Date: Fri, 9 Mar 2007 15:54:39 -0500
Message-ID: <d120d5000703091254t350216b3wfb679a53294b0e5a@mail.gmail.com>
References: <20070228110631.86a150e4.zaitcev@redhat.com>
	 <d120d5000703090628p46556d52qb94b523fda4e947d@mail.gmail.com>
	 <20070309103656.cd681677.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070309103656.cd681677.zaitcev@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 3/9/07, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Fri, 9 Mar 2007 09:28:49 -0500, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> > On 2/28/07, Pete Zaitcev <zaitcev@redhat.com> wrote:
>
> > > Dmitry, please consider getting rid of the list of handles entirely.
> > > The other major user is drivers/char/keyboard.c.
> >
> > I agree that handlers should not access h_list nad use their own
> > private lists instead. However input core still needs that list to
> > maintain its books.
>
> Hmm. So it appears that my patch wastes 2 ulongs per input handle
> then, in the name of preventing oopses. OK.
>

Think about the time when everyone switches to evdev-based input
drivers. Then we can forget about mousedev wasting some extra memory
;)

-- 
Dmitry
