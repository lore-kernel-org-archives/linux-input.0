From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input - Add Euro and Dollar keys
Date: Fri, 26 Oct 2007 00:41:25 -0400
Message-ID: <200710260041.26041.dmitry.torokhov@gmail.com>
References: <200710251356.21758.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710251356.21758.cathectic@slackadelic.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Carlos Corbacho <cathectic@slackadelic.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Thursday 25 October 2007, Carlos Corbacho wrote:
> From: Carlos Corbacho <cathectic@gmail.com>
> 
> Most newer Acer laptops (from 2005 onwards) now ship with an extra Dollar
> and Euro key either side of the 'Up' arrow. These cannot be mapped in the 
> traditional way, since they are not combination keys.

Applied, thank you Carlos. I tought about KEY_CURRENCY some more and I
don't think it would work well in this case.

-- 
Dmitry
