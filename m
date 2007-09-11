From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [HP Jornada 6XX] - Onboard Keyboard support
Date: Tue, 11 Sep 2007 14:32:41 -0400
Message-ID: <d120d5000709111132p44707636m4ff07c0070aedbf9@mail.gmail.com>
References: <20070721181549.9d118414.Kristoffer.Ericson@Gmail.com>
	 <200707220145.10563.dtor@insightbb.com>
	 <20070726223452.e6d8f7c3.Kristoffer.Ericson@Gmail.com>
	 <d120d5000707300539haa26ae8sdfee043ae9e64688@mail.gmail.com>
	 <20070910145836.bc268d5d.Kristoffer.Ericson@Gmail.com>
	 <d120d5000709100601u1a5a0208g903c4463119c3702@mail.gmail.com>
	 <20070911012234.5257be24.Kristoffer.Ericson@Gmail.com>
	 <d120d5000709110814g59189dbdx1b79fa316c947d8e@mail.gmail.com>
	 <20070911184248.bdebfc4e.Kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070911184248.bdebfc4e.Kristoffer.ericson@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 9/11/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> On Tue, 11 Sep 2007 11:14:37 -0400
> "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
>
> > On 9/11/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> > > On Mon, 10 Sep 2007 09:01:51 -0400
> > > "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> > >
> > > > I am
> > > > attaching a patch that has it impoemented a bit differently, could you
> > > > tell me if it is still works for you?
> > >
> > > It works, but the keys it returns are wrong. For instance enter returns 'z'. Somehow the *table must be off. I havent looked at it more closely, but will tommorow.
> > >
> >
> > Yes, I messed up the inner loop. What about this one?
>
> That seems to work according to my tester. So if you are satisfied, please go ahead and commit it.
>

Ok, will do. Thank you for testing.

-- 
Dmitry
