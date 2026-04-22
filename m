Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1763C1969;
	Wed, 22 Apr 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849685; cv=none; b=an3w+0lkkPn0wAiTpKQDyThOqdDDsMGXM3VxkOzJwLtH33YXOxJYZRvUfVHWiaL87EnXHym/ZDMfzHhY3SCPpg49G6WsGuoMFAYDTP6ZWXZ9E5JxpQHdpr+7iwqL6CiB2Ouf9Bym7wCy+fwnPR6O6bpVh2dtC01zbqx7C9XRvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849685; c=relaxed/simple;
	bh=PdXiKgN1WwkW7fLQ8YPU2cLfn8tsQW6SDMXfqR+rJOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRJN3UWnvgYCuzdfDS7FbLZqS0zep77LEMqx8r7gR3tuc7clBdQA33toa14DeYEZLZisCjhGaQDAyVRWdtTl27hquNbZsYjGDiEFdcligdF+LVr8oi3HYBbH/xZYKj/wOc20ChCjC5f+fXyz0QcJxrjJdqlqPY+S4dpNhjyA6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vn657MiR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vn657MiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849684; x=1808385684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PdXiKgN1WwkW7fLQ8YPU2cLfn8tsQW6SDMXfqR+rJOc=;
  b=Vn657MiRDCYQfiN7EA1N/lU5p0M0RWmURFMtwVzXyfrRhDfY24TEHlLJ
   UDe7G0GD7el6qQCkbUOUpsj7Iw157T316Oh7fU//W0Wxe+C0kE3g5fjgW
   fweXKp4AhMrS99tL5B8pjPqipwqPvpu57+GY9Czv1SvoZ4UnSpUb/4Z5D
   Er6jmqxIHOrlFyMm6wPb6eEWx6032inwB7p6TcdeCBRlVAZ79wVyFONWv
   GFryiUXa/lKUX20hZcCzPo8oy0Ne87+h/akyWVdXRSE1TZZPkdZA2N5uk
   OoQGImT2cCg0DlM4jfYHaajNvhCNtD52H1LRXjIAWSrsdvMu8yHCg+4nZ
   Q==;
X-CSE-ConnectionGUID: lXYXKrhoRqGnx/nxvbEmvg==
X-CSE-MsgGUID: CQjojAIDQoWCzInizox3lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="80385172"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="80385172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:21:23 -0700
X-CSE-ConnectionGUID: hYBTP+mJQ4uQY6u71ZZb6g==
X-CSE-MsgGUID: xtF/MAFAQDqD3lJ8LRpqVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232167738"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:21:21 -0700
Date: Wed, 22 Apr 2026 12:21:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add helper method
 hid_sensor_adjust_channel_bit_mask()
Message-ID: <aeiTDr511xGLBkGx@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:20:32PM -0300, Natália Salvino André wrote:
> This patch series introduces a generic helper function to handle channel bit mask adjustments
> for HID sensors. Currently, multiple drivers implement identical logic for this task

This message should be wrapped on ~72 characters. Some of the maintainers may
use cover letter as fake-merge commit message. And even if not, the standards
in the kernel for the cover letter and commit messages are the same in terms of
writing rules.

Basically this is the biggest issue in the whole series: missed proper
indentation / wrapping.

Code wise looks good, thanks for doing this!

-- 
With Best Regards,
Andy Shevchenko


